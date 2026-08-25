# Handoff — current state

> **This file is the single source of truth for project status.** If any other document disagrees
> with it, this one wins and the drift should be fixed. See `AGENTS.md` §3.

**Last updated:** 2026-08-26 — [PR #3](https://github.com/BinHsu/aegis-template/pull/3) squash-merged to
`main` as `cb706c7`. Issues **#1** and **#2** closed completed. Merge CI
`32900273254` settled green.

---

## 1. Read these first

1. `docs/handoff/CURRENT.md` (this file)
2. `README.md`
3. `AGENTS.md`
4. `SECURITY.md`

You do **not** need any conversation history. If something here is unclear, that is a defect in this
file — fix it rather than guessing.

## 2. Last completed milestone

Three-layer rule-book skeleton (`AG-LAYER`) plus stay-put **pointer** (`AG-GIT` →
`~/.claude/ENGINEERING.md` "Handoff is git and only git", See / verdict / edit — not a second copy).
Stripped `bin/check` (Codex 32 KiB budget + obligation↔case; orphans red; both-empty green). CI
self-test-then-run.

| Commit | Content |
|---|---|
| `cb706c7` | Squash of PR #3: three-layer skeleton, orphan-refusing checker, AG-GIT pointer |
| `b7b2ded` | Add a per-file index, Codex-runnable acceptance criteria, and fix checks that could not fail |

## 3. Repository state

- Branch: `main` @ `cb706c7`
- Remote: `https://github.com/BinHsu/aegis-template.git`
- Visibility: public template repository
- Local path is machine-specific and deliberately not recorded here.

## 4. Environment / system state

- `#1` and `#2` **CLOSED completed** 2026-08-25T21:18Z. `VERIFIED` (`gh issue view`).
- `BinHsu/dotClaude#11` closed completed via PR #13, merge `cfe9fb7`. Consumer form is a pointer.
- No open PRs, no open issues at merge time (`gh pr list` / `gh issue list` to re-check).

## 5. Commands already run

```
gh pr merge 3 --squash --admin --delete-branch
# MERGED cb706c7e58a62d07ca2a77338a0fc55aa4a2244e

gh run watch 32900273254 --exit-status
# main Security Checks green, including Agent-policy checker self-test and Agent-policy checker
```

Local before merge: `bash bin/check --self-test` (38 assertions) and `bash bin/check` (2:2,
13650 B / 41%).

## 6. Test results

| Check | Result |
|---|---|
| PR #3 CI `32899947728` | green |
| **main** CI `32900273254` after merge | green (`VERIFIED`, `gh run watch --exit-status`) |

## 7. Current blockers, in priority order

None.

## 8. AWAITING DECISION — owner only

None.

## 9. Exact next safe action

```bash
gh issue list --repo BinHsu/aegis-template --state open
```

If that is empty, the next work is whatever the owner files. Do not invent a ticket. Do not copy
the ENGINEERING.md See / verdict / edit table into this template.

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
