"""`scripts/safe-exec.sh` wraps destructive commands as preview -> confirm -> log -> execute
(AGENTS.md §10). `BinHsu/truewatch-topic-inventory#244`: the pre-fix preview step for
`rm -f`/`rm -rf` built its "Would remove:" listing by string-substituting the command
(`rm -rf` -> `ls -la`) and then `eval`-ing the result. That is unsafe on two counts, both
demonstrated here:

1. `rm -f` is not a substring of `rm -rf`, so the substitution never fires for `rm -f`
   commands, and `eval` runs the ORIGINAL `rm -f ...` before the user is ever asked to
   confirm.
2. For `rm -rf A B` where any path is missing, `ls -la` exits non-zero, its stderr is
   swallowed by `2>/dev/null`, and `||` falls through to a second substitution that also
   misses (same reason as #1) -- so `eval` again runs the original `rm -rf ...`.

Both paths delete real files before the `read -r -p "Type 'confirm'"` prompt and before
the destructive-log write. This drives the real script end-to-end via subprocess (the
same technique `tests/test_check_stray_clones.py` and `tests/test_backfill_tmp_mirror.py`
use), in a disposable per-test tmp directory, feeding "no" on stdin so a correctly-working
script would abort without touching the filesystem. Every assertion here is "the file
still exists after the preview ran" -- not "the script printed the right thing".
"""

from __future__ import annotations

import json
import sys
import subprocess
import tempfile
import unittest
from pathlib import Path

SCRIPT = Path(__file__).resolve().parent.parent / "scripts" / "safe-exec.sh"


def _run(cwd: Path, args: list[str], answer: str = "no") -> subprocess.CompletedProcess:
    return subprocess.run(
        ["bash", str(SCRIPT), *args],
        cwd=cwd,
        input=answer + "\n",
        capture_output=True,
        text=True,
    )


class SafeExecPreviewDoesNotDeleteTests(unittest.TestCase):
    """`#244` condition 2: the three named inputs, each asserting the previewed path(s)
    still exist after the preview runs and the user declines to confirm."""

    def setUp(self) -> None:
        self._tmp = tempfile.TemporaryDirectory()
        self.cwd = Path(self._tmp.name)

    def tearDown(self) -> None:
        self._tmp.cleanup()

    def test_rm_f_existing_path_survives_declined_preview(self) -> None:
        target = self.cwd / "existing.txt"
        target.write_text("keep me")

        result = _run(self.cwd, ["rm", "-f", "existing.txt"], answer="no")

        self.assertTrue(
            target.exists(),
            f"rm -f preview deleted {target} before confirm; stdout={result.stdout!r}",
        )
        self.assertNotEqual(result.returncode, 0, "declining confirm must abort")
        self.assertIn("Aborted", result.stdout)

    def test_rm_rf_existing_plus_missing_path_survives_declined_preview(self) -> None:
        target = self.cwd / "existing.txt"
        target.write_text("keep me")
        missing = self.cwd / "does-not-exist.txt"
        self.assertFalse(missing.exists())

        result = _run(
            self.cwd, ["rm", "-rf", "existing.txt", "does-not-exist.txt"], answer="no"
        )

        self.assertTrue(
            target.exists(),
            f"rm -rf preview deleted {target} (alongside a missing path) before confirm; "
            f"stdout={result.stdout!r}",
        )
        self.assertNotEqual(result.returncode, 0, "declining confirm must abort")

    def test_rm_rf_single_existing_path_survives_declined_preview(self) -> None:
        target = self.cwd / "existing.txt"
        target.write_text("keep me")

        result = _run(self.cwd, ["rm", "-rf", "existing.txt"], answer="no")

        self.assertTrue(
            target.exists(),
            f"rm -rf preview deleted {target} before confirm; stdout={result.stdout!r}",
        )
        self.assertNotEqual(result.returncode, 0, "declining confirm must abort")

    def test_chained_command_string_does_not_delete_second_target(self) -> None:
        """Not one of #244's three named inputs, but found applying the same mask: the
        pre-fix preview called `eval` on a string derived from CMD, so a single-argument
        invocation carrying a shell separator (`;`) let a SECOND destructive command ride
        through untouched by the (already-broken) rm -rf -> ls -la substitution, which only
        ever rewrites the first occurrence. Preview must never hand CMD to a shell at all."""
        a = self.cwd / "a.txt"
        b = self.cwd / "b.txt"
        a.write_text("keep me")
        b.write_text("keep me too")

        result = _run(self.cwd, ["rm -rf a.txt; rm -f b.txt"], answer="no")

        self.assertTrue(a.exists(), f"first target deleted; stdout={result.stdout!r}")
        self.assertTrue(b.exists(), f"chained second target deleted; stdout={result.stdout!r}")

    def test_confirming_still_actually_deletes(self) -> None:
        """Guard against a fix that neuters the preview so thoroughly it breaks the real,
        confirmed execution path -- the script must still delete when the user types
        'confirm'."""
        target = self.cwd / "existing.txt"
        target.write_text("delete me")

        result = _run(self.cwd, ["rm", "-f", "existing.txt"], answer="confirm")

        self.assertEqual(result.returncode, 0, f"confirmed rm failed: {result.stderr}")
        self.assertFalse(target.exists(), "confirming must still execute the command")


class SafeExecArgvTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.cwd = Path(self.tmp.name)
        self.addCleanup(self.tmp.cleanup)

    def test_unclassified_command_requires_confirmation_and_eof_aborts(self):
        for answer in ["no", "", "yes"]:
            with self.subTest(answer=answer):
                result = _run(self.cwd, [sys.executable, "-c",
                    "from pathlib import Path; Path('ran').touch()"], answer)
                self.assertNotEqual(result.returncode, 0)
                self.assertFalse((self.cwd / "ran").exists())
                self.assertFalse((self.cwd / ".agent-context").exists())
        result = subprocess.run(["bash", str(SCRIPT), "touch", "ran"],
            input="", cwd=self.cwd, text=True, capture_output=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse((self.cwd / "ran").exists())

    def test_literal_arguments_and_receipt_exist_before_child_runs(self):
        args = ["space name", "", "$(touch injected)", "semi;touch injected",
                'quote"value', "line\nbreak", "*.txt", "--"]
        code = ("import json,sys; from pathlib import Path; "
                "r=json.loads(Path('.agent-context/destructive-log.jsonl').read_text()); "
                "assert r['argv'][3:]==sys.argv[1:]; "
                "Path('observed.json').write_text(json.dumps(sys.argv[1:]))")
        result = _run(self.cwd, [sys.executable, "-c", code, *args], "confirm")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(json.loads((self.cwd / "observed.json").read_text()), args)
        self.assertFalse((self.cwd / "injected").exists())

    def test_logging_failure_prevents_execution(self):
        (self.cwd / ".agent-context").write_text("not a directory")
        result = _run(self.cwd, ["touch", "ran"], "confirm")
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse((self.cwd / "ran").exists())

    def test_child_exit_status_and_append_only_receipts(self):
        for code in [7, 0]:
            result = _run(self.cwd, [sys.executable, "-c", f"raise SystemExit({code})"], "confirm")
            self.assertEqual(result.returncode, code, result.stderr)
        lines = (self.cwd / ".agent-context/destructive-log.jsonl").read_text().splitlines()
        self.assertEqual(len(lines), 2)
        self.assertEqual([json.loads(line)["argv"][-1] for line in lines],
                         ["raise SystemExit(7)", "raise SystemExit(0)"])

    def test_no_arguments_refused_without_log(self):
        result = _run(self.cwd, [], "confirm")
        self.assertEqual(result.returncode, 2)
        self.assertFalse((self.cwd / ".agent-context").exists())


if __name__ == "__main__":
    unittest.main()
