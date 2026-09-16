# Handoff — historical record

> 2026-09-16 supersession: AGENTS.md v2 assigns live work to git status/history
> and scoped PRs/issues. All status authority, standing instructions and next
> actions below are retained as history, not current authorization.

> **This file is the single source of truth for project status.** If any other document disagrees
> with it, this one wins and the drift should be fixed. See `AGENTS.md` §3.

**Last updated:** 2026-09-04 — branch `harness-block` opened off `main` @ `53abb0b`, carrying the
D1 ruling in `BinHsu/dotClaude#34`: the `AGENTS.md` harness content is now stamped with
`<!-- harness:begin v=1 -->` markers, recorded in `harness/`, and audited by
`bin/check-harness-block` (warn-and-diff, never rewrite). PR open against `main`, **not merged**.
Everything described in §2a below as issue **#5** work is now merged (`3b294cf`); `main` has also
taken PR **#8** (`d5112d8`, vacuous-checker counting) and `53abb0b` (`conventions.md`).

---

## 1. Read these first

1. `docs/handoff/CURRENT.md` (this file)
2. `README.md`
3. `AGENTS.md`
4. `SECURITY.md`

You do **not** need any conversation history. If something here is unclear, that is a defect in this
file — fix it rather than guessing.

## 2. Last completed milestone (merged to `main`)

Three-layer rule-book skeleton (`AG-LAYER`) plus stay-put **pointer** (`AG-GIT` →
`~/.claude/ENGINEERING.md` "Handoff is git and only git", See / verdict / edit — not a second copy).
Stripped `bin/check` (Codex 32 KiB budget + obligation↔case; orphans red; both-empty green). CI
self-test-then-run.

| Commit | Content |
|---|---|
| `cb706c7` | Squash of PR #3: three-layer skeleton, orphan-refusing checker, AG-GIT pointer |
| `b7b2ded` | Add a per-file index, Codex-runnable acceptance criteria, and fix checks that could not fail |

## 2a. In progress — not yet merged: branch `harness-block`

Related issue: `BinHsu/dotClaude#34` (cross-repo; that issue tracks all three PRs and must stay
open until the console repo's PR lands too — so this PR says `參見 #34`, never a closing keyword).

**What changed, and why each way round.** Codex and Cursor do not expand `@` imports, so harness
policy cannot be imported into a scaffolded repo — it must exist physically there. This branch stops
treating that forced copy as trustworthy:

- `AGENTS.md`: four `<!-- harness:begin v=1 -->` … `<!-- harness:end -->` regions around exactly the
  content every scaffolded repo must carry verbatim. The `{{placeholders}}`, §1, §2, §13 and §9's
  repo-specific destructive-operations tail all sit **outside** the markers, on purpose.
- `bin/check-harness-block` (new): extracts the regions, hashes them against `harness/HASH`, and on
  drift names the section and prints a unified diff. Takes a path, so a fresh clone of this template
  can audit a downstream repo. **Exits non-zero, never edits a file, and has no `--fix`.**
  16 self-test assertions.
- `bin/check`: third clause, delegating to the above; three more self-test assertions prove the
  wiring and the tally still react.
- **Backflowed** §12 from a consumer repo, whose six-line pointer at the
  `no-vacuous-checks` skill is *newer* than the 26 lines this template still carried.
- **Pointers, not deletions:** §8 → `~/.claude/ENGINEERING.md` "When to stop, and when to keep
  going"; §11 step 4 → its "Records" diff-table rule; `CLAUDE.md` "Delegation boundary" → its
  "Delegation" section plus the `delegation` skill. Each keeps one sentence stating the rule.
- **Moved in** from the console repo: the non-Claude bootstrap banner and
  `scripts/read-global-policy.py` it names.
- §5 (evidence tags) is general, not scaffold-specific. It is **marked** a candidate to move up to
  `~/.claude/ENGINEERING.md` (`BinHsu/dotClaude#34`) and left here **in full** — moving it is
  another repo's PR, and until it exists there this is the only copy.

🔴 **Why the audit only warns.** Measured 2026-09-04: a consumer repo's §12 was *newer*
than this template's. An auto-sync in either direction would have destroyed the good copy silently.
Which side moves is a human decision, every time. Reasoning: `AGENTS.cases/AG-HARNESS.md`.

## 2b. Merged earlier — issue #5 (`.gitignore` default-deny)

**Issue #5**: `.gitignore` was a pure blocklist and missed 14 of 18 credential-bearing dotfiles
(`.envrc`, `.netrc`, `.npmrc`, `.pypirc`, `.git-credentials`, `.ssh/`, `.docker/`, `.kube/`,
`.gnupg/`, `.direnv/`, `.codex/`, `.mcp.json`, `.scratch/`, `.terraformrc`), and the pre-commit
content scan's quoted-value regex catches none of them either (same gap, two independent guards).

Fix on branch `issue-5-gitignore-default-deny`: default-deny block (`.*`) at the **top** of
`.gitignore`, followed by a five-line allowlist (`!.gitignore`, `!.claude/`, `!.githooks/`,
`!.github/`, `!.semgrep/`) re-admitting the tracked scaffold directories. Both silent traps named
in the issue — position/last-match-wins, and negations must name directories not files — are
written as comments directly above the block, plus the accepted cost (a genuinely new dotfile
needs its own `!` line). `docs/FILE-MAP.md`'s `.gitignore` row updated to match.

Verified locally with `git check-ignore --no-index -q <path>` (exit code, not printed output —
`-v` prints a matching negation line too, which inverted two rows on the first pass of the
underlying investigation): 31 cases run, all pass — the issue's 9 must-allow + 15 must-block,
plus synthetic new files under each allowlisted directory (`.claude/skills/NEW/SKILL.md`,
`.github/workflows/NEW.yml`, `.semgrep/NEW.yml`) and four regression checks on pre-existing
patterns (`.claude/settings.local.json`, `CLAUDE.local.md`, `*.pem`, `*.crt.example`). Also
reproduced the position trap directly against this file: moving the same six lines to the end
re-ignored `.env.example` (its negation sits earlier in the file and `.*` at the bottom wins).

Deliberately **not** touched by this change (named in the issue as worth its own ticket, not part
of this closing condition): the pre-commit content-scan regex's quoted-value assumption and
missing PEM-block pattern.

## 3. Repository state

- Branch: `harness-block` off `main` @ `53abb0b`, PR open against `main`, **not merged**.
  `main` @ `53abb0b`. Re-read with `git log --oneline -5` and `gh pr list` rather than this line.
- Remote: `https://github.com/BinHsu/aegis-template.git`
- Visibility: public template repository
- Local path is machine-specific and deliberately not recorded here.

## 4. Environment / system state

- `#1` and `#2` **CLOSED completed** 2026-08-25T21:18Z. `VERIFIED` (`gh issue view`).
- `#5` **OPEN**, PR filed against it, awaiting owner review/merge.
- `BinHsu/dotClaude#11` closed completed via PR #13, merge `cfe9fb7`. Consumer form is a pointer.
- Re-check with `gh pr list` / `gh issue list` rather than trusting this snapshot.

## 5. Commands already run

```
gh pr merge 3 --squash --admin --delete-branch
# MERGED cb706c7e58a62d07ca2a77338a0fc55aa4a2244e

gh run watch 32900273254 --exit-status
# main Security Checks green, including Agent-policy checker self-test and Agent-policy checker
```

Local before merge of PR #3: `bash bin/check --self-test` (38 assertions) and `bash bin/check`
(2:2, 13650 B / 41%).

For issue #5 (branch since merged): `bash bin/check` (2:2, green), `python3
scripts/cleanup-scanner.py` (clean), `python3 tests/test_evidence_artifacts.py` (vacuous pass), and
the 31-case `git check-ignore --no-index -q` matrix described in 2b.

For branch `harness-block`:

```
python3 bin/check-harness-block --self-test        # 16 assertions, all as expected
bash bin/check --self-test                         # 41 assertions (was 38), all as expected
bash bin/check                                     # 3 clauses green: budget 46%, 3:3 cases, block v=1
python3 bin/check-harness-block                    # green against this repo's own AGENTS.md
python3 bin/check-harness-block <path-to-a-consumer-repo>/AGENTS.md   # exit 1, 6 of 13 sections
```

The console repo was read only; `git -C ~/a consumer repo status --porcelain` was empty
before and after.

## 6. Test results

| Check | Result |
|---|---|
| PR #3 CI `32899947728` | green |
| **main** CI `32900273254` after merge | green (`VERIFIED`, `gh run watch --exit-status`) |
| Issue #5 branch, local `bin/check` | green, 2:2, unaffected by this change |
| Issue #5 branch, 31-case gitignore matrix | all pass (see 2a) |
| Issue #5 PR CI | green; merged as `3b294cf` |
| `harness-block`, `bin/check-harness-block --self-test` | 16/16 as expected |
| `harness-block`, `bin/check --self-test` | 41/41 as expected |
| `harness-block`, `bin/check` | green, 3 clauses, none yellow |
| `harness-block`, audit vs a consumer repo | exit 1 as designed — unstamped, and 6 of 13 canonical sections drifted or missing (that repo's PR is the third in `BinHsu/dotClaude#34`) |
| `harness-block` PR CI | not yet observed — watch the run after push, per this repo's own §8 (don't
  stop at "pushed"; watch until it settles) |

## 7. Current blockers, in priority order

None. PR for issue #5 is open and waiting on owner review/merge — that is the owner's decision,
not a blocker on further agent work.

## 8. AWAITING DECISION — owner only

- **Merge or reject the `harness-block` PR.** If rejected, the grounds belong in a PR comment
  before closing it (see `~/.claude/ENGINEERING.md` "Handoff is git and only git" — rejecting is an
  action, not a close), and the branch stays.
- **Whether §5 (evidence tags) moves up to `~/.claude/ENGINEERING.md`.** Marked as a candidate in
  this PR, text unmoved. That is a different repo's change.

## 9. Exact next safe action

```bash
gh pr checks --repo BinHsu/aegis-template <PR-number-for-harness-block>
```

If green and the owner has not yet ruled, the next work in `BinHsu/dotClaude#34`'s sequence is the
**console repo's** PR (a consumer repo: stamp its block, split its §13, take this
template's `AG-LAYER` and `## git`) — and it is only unblocked once this one is merged, because it
depends on the marker convention and on `harness/`. Do not start it here. Do not copy the
ENGINEERING.md See / verdict / edit table into this template.

## 10. Things that will bite you

- **Do not copy the ENGINEERING.md See / verdict / edit table into this template.** `#11` put the
  body in one home. `#2` closed with a pointer. A second copy is the defect the issue named.
- **Do not copy toolkit-only `bin/check` clauses** (`git-hookspath`, `pattern-index`,
  `sibling-homes`, `tg-safety-docs`, `conventions-reachability`). This template does not contain
  those targets; a check against absent code is a check that cannot fail (`AGENTS.md` §12).
- **Do not wire `check_git_hookspath` into CI.** GitHub Actions checkouts do not set
  `core.hooksPath`; that clause would be permanently red on every PR.
- **Evidence correspondence ≠ rule↔case correspondence.**
- **`<!-- obligation:<ID> -->` examples must keep the angle brackets.** Measured 2026-08-26:
  `YOUR-ID` without brackets turned `bin/check` red.
- **`/bin/` in `.gitignore` would have dropped `bin/check` with no error.** Current pattern is
  `/bin/*` plus `!/bin/check`.
- **Never add auto-sync to the harness block.** Measured 2026-09-04: a consumer repo's §12 was
  newer than this template's, so an auto-sync would have overwritten the good copy with the stale
  one. `bin/check-harness-block` has no `--fix` and its emit flags print to stdout on purpose.
- **After editing anything inside the `harness:` markers, re-emit both `harness/` files** and bump
  `v=`, in the same commit. `bin/check` goes red otherwise — that is the point.
- **`!/bin/check` in `.gitignore` is an exact match, not a prefix.** `bin/check-harness-block`
  needed its own `!` line or it would have been untracked in every scaffolded repo, i.e. the audit
  would have silently not existed.
- **`scripts/check-file-map.sh` is a `PostToolUse` hook and reads a JSON payload on stdin.** Run by
  hand with no stdin it hangs; that is not a failure of the check.
- **`main` requires a squash PR** (ruleset `main-protection`: linear history, required review,
  required signatures). Direct push is blocked; admin bypass exists. A merge run is a different
  CI run from the PR's — watch it.
