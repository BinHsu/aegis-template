# Handoff — current state

> **This file is the single source of truth for project status.** If any other document disagrees
> with it, this one wins and the drift should be fixed. See `AGENTS.md` §3.

**Last updated:** 2026-08-26 — issue **#5** (`.gitignore` blocklist gap) addressed on branch
`issue-5-gitignore-default-deny`, PR opened against `main`, not yet merged. Base for this work:
[PR #3](https://github.com/BinHsu/aegis-template/pull/3) squash-merged to `main` as `cb706c7`.
Issues **#1** and **#2** closed completed. Merge CI `32900273254` settled green.

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

## 2a. In progress — not yet merged

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

- Branch: `main` @ `cb706c7`; work-in-progress branch `issue-5-gitignore-default-deny` off `main`
  @ `d751c05`, PR open against `main` (see PR link in the commit this file is part of / `gh pr list`)
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

For issue #5 (this branch): `bash bin/check` (2:2, green, unaffected — `.gitignore` is outside its
budget/correspondence scope), `python3 scripts/cleanup-scanner.py` (clean), `python3
tests/test_evidence_artifacts.py` (vacuous pass, unaffected), and the 31-case
`git check-ignore --no-index -q` matrix described in 2a.

## 6. Test results

| Check | Result |
|---|---|
| PR #3 CI `32899947728` | green |
| **main** CI `32900273254` after merge | green (`VERIFIED`, `gh run watch --exit-status`) |
| Issue #5 branch, local `bin/check` | green, 2:2, unaffected by this change |
| Issue #5 branch, 31-case gitignore matrix | all pass (see 2a) |
| Issue #5 PR CI | not yet observed — watch the run after push, per this repo's own §8 (don't
  stop at "pushed"; watch until it settles) |

## 7. Current blockers, in priority order

None. PR for issue #5 is open and waiting on owner review/merge — that is the owner's decision,
not a blocker on further agent work.

## 8. AWAITING DECISION — owner only

- **Merge or reject PR for issue #5.** If rejected, the grounds belong in a PR comment before
  closing it (see `~/.claude/ENGINEERING.md` "Handoff is git and only git" — rejecting is an
  action, not a close).

## 9. Exact next safe action

```bash
gh pr checks --repo BinHsu/aegis-template <PR-number-for-issue-5>
```

If green and the owner has not yet ruled, the next work is whatever the owner files next — do not
invent a ticket. The pre-commit content-scan gap noted in 2a is a candidate for a **new** issue,
not silently folded into #5's scope. Do not copy the ENGINEERING.md See / verdict / edit table
into this template.

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
- **`main` requires a squash PR** (ruleset `main-protection`: linear history, required review,
  required signatures). Direct push is blocked; admin bypass exists. A merge run is a different
  CI run from the PR's — watch it.
