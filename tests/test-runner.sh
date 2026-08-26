#!/usr/bin/env bash
# bin/test must be able to tell a skip from a pass, and say so in its exit status.
#
# The runner is the only thing here that can see across suites, so it is the only place
# where "ran, found nothing to check, exited 0" can be caught. That makes its own behaviour
# worth testing against outcomes known in advance rather than against the real suites,
# whose results depend on what evidence this clone happens to hold.
#
# Case 3 is the one that makes the rest worth having: the same fixtures under --strict must
# go red. If they do not, the runner cannot distinguish coverage from its absence and every
# other assertion here is decoration.

set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() { echo "FAIL: $*" >&2; exit 1; }

bash -n "$REPO/bin/test" || fail "bin/test is not valid bash"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# mk_sh / mk_py <dir> <name> <exit> [skip-count] — both languages, because the marker
# contract is language-agnostic and a runner that only understood shell would silently
# ignore this repo's actual test.
mk_sh() {
  local dir="$1" name="$2" code="$3" skips="${4:-0}" i
  mkdir -p "$dir"
  {
    echo '#!/usr/bin/env bash'
    for ((i = 1; i <= skips; i++)); do
      echo "echo '## SKIP $name/case$i — fixture reason'"
    done
    echo "echo 'ok: $name'"
    echo "exit $code"
  } >"$dir/$name.sh"
}

mk_py() {
  local dir="$1" name="$2" code="$3" skips="${4:-0}" i
  mkdir -p "$dir"
  {
    echo 'import sys'
    for ((i = 1; i <= skips; i++)); do
      echo "print('## SKIP $name/case$i — fixture reason')"
    done
    echo "print('ok: $name')"
    echo "sys.exit($code)"
  } >"$dir/$name.py"
}

run() {  # run <dir> [args...] -> sets OUT and RC
  local dir="$1"; shift
  set +e
  OUT="$(TESTS_DIR="$dir" bash "$REPO/bin/test" "$@" 2>&1)"
  RC=$?
  set -e
}

# 1. Everything clean, in both languages: exit 0.
mk_sh "$TMP/clean" test_alpha 0 0
mk_py "$TMP/clean" test_beta 0 0
run "$TMP/clean"
[[ $RC -eq 0 ]] || fail "all-clean run should exit 0, got $RC ($OUT)"
grep -q 'test_alpha .*PASS' <<<"$OUT" || fail "shell suite not reported PASS: $OUT"
grep -q 'test_beta .*PASS' <<<"$OUT" || fail "python suite not run or not PASS: $OUT"
grep -q '2 suite(s): 2 clean, 0 with skips, 0 failed' <<<"$OUT" || fail "wrong tally: $OUT"
echo "  ok: both languages discovered and run; all clean -> exit 0"

# 2. A suite that exits 0 having declined a case is NOT a pass, and the case is named.
mk_sh "$TMP/skipping" test_alpha 0 0
mk_py "$TMP/skipping" test_vacuous 0 2
run "$TMP/skipping"
[[ $RC -eq 0 ]] || fail "default mode should tolerate a skip, got $RC"
grep -q 'test_vacuous .*SKIP(2)' <<<"$OUT" || fail "a skipping suite was reported as PASS: $OUT"
grep -q 'test_vacuous/case1' <<<"$OUT" || fail "the declined case was not named: $OUT"
grep -q '2 case(s) skipped' <<<"$OUT" || fail "skips not counted: $OUT"
echo "  ok: a suite exiting 0 with declined cases is SKIP, and the cases are named"

# 3. The discriminator.
run "$TMP/skipping" --strict
[[ $RC -ne 0 ]] || fail "--strict exited 0 with 2 declined cases — a skip is passing as coverage"
echo "  ok: --strict turns a declined case into a non-zero exit"

# 4. A real failure fails in both modes, and the suite's own output survives.
mk_sh "$TMP/failing" test_alpha 0 0
mk_py "$TMP/failing" test_delta 1 0
run "$TMP/failing"
[[ $RC -ne 0 ]] || fail "a failing suite exited 0"
grep -q 'test_delta .*FAIL' <<<"$OUT" || fail "failure not reported: $OUT"
grep -q 'ok: test_delta' <<<"$OUT" || fail "a failing suite's own output was swallowed: $OUT"
run "$TMP/failing" --strict
[[ $RC -ne 0 ]] || fail "a failing suite exited 0 under --strict"
echo "  ok: a failing suite is non-zero in both modes, with its output shown"

# 5. An empty tests directory is an error, not a pass. A scaffolded repo that deletes its
#    only suite must not inherit a green runner.
mkdir -p "$TMP/empty"
run "$TMP/empty"
[[ $RC -eq 2 ]] || fail "an empty tests dir should exit 2, got $RC ($OUT)"
echo "  ok: no suites at all is an error"

# 6. Naming suites runs only those.
run "$TMP/skipping" test_alpha
[[ $RC -eq 0 ]] || fail "selecting the clean suite should exit 0, got $RC"
grep -q 'test_vacuous' <<<"$OUT" && fail "an unselected suite ran anyway: $OUT"
grep -q '1 suite(s)' <<<"$OUT" || fail "selection did not narrow the run: $OUT"
echo "  ok: named suites run alone"

# 7. The real suites, checked by behaviour rather than by grepping their source. An
#    earlier version of this case scanned for words like "vacuous" and flagged the
#    validator's own self-test, which asserts that an empty directory passes vacuously —
#    test code about the path, not a declined case. A guard with false positives gets
#    turned off, so this runs the suites and holds them to one rule instead: a suite that
#    says it passed without checking anything must also say so in a line the runner counts.
for real in "$REPO"/tests/test*.py "$REPO"/tests/test*.sh; do
  [[ -e "$real" ]] || continue
  [[ "$(basename "$real")" == "test-runner.sh" ]] && continue
  set +e
  case "$real" in
    *.py) real_out="$(python3 "$real" 2>&1)" ;;
    *) real_out="$(bash "$real" 2>&1)" ;;
  esac
  set -e
  if grep -Eqi 'vacuous|nothing to check|not-implemented' <<<"$real_out"; then
    grep -q '^## SKIP ' <<<"$real_out" \
      || fail "$(basename "$real") reports passing without checking anything, but prints no '## SKIP' line, so bin/test counts it as coverage:
$real_out"
  fi
done
echo "  ok: a suite that passes without checking anything declares it countably"

echo "ok: test-runner (a skip is not a pass; --strict discriminates)"
