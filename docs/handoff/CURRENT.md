# Handoff — current state

> **This file is the single source of truth for project status.** If any other document disagrees
> with it, this one wins and the drift should be fixed. See `AGENTS.md` §3.

**Last updated:** 2026-08-26 — `#2` pointer landed on `issue-1-three-layer-skeleton` after
`BinHsu/dotClaude#11` closed. [PR #3](https://github.com/BinHsu/aegis-template/pull/3) should close
`#1` and `#2`.

---

## 1. Read these first

1. `docs/handoff/CURRENT.md` (this file)
2. `README.md`
3. `AGENTS.md`
4. `SECURITY.md`

You do **not** need any conversation history. If something here is unclear, that is a defect in this
file — fix it rather than guessing.

## 2. Last completed milestone

`#1` three-layer skeleton plus `#2` stay-put **pointer** (not a second copy of the global rule).

| Commit | Content |
|---|---|
| (this branch, unpushed until committed) | AG-GIT pointer + `AGENTS.cases/AG-GIT.md` |
| `5940d67` | Add a three-layer rule-book skeleton and an orphan-refusing checker |
| `b7b2ded` | Add a per-file index, Codex-runnable acceptance criteria, and fix checks that could not fail |

## 3. Repository state

- Branch: `issue-1-three-layer-skeleton` (from `main` @ `b7b2ded`)
- Remote: `https://github.com/BinHsu/aegis-template.git`
- Visibility: public template repository
- Local path is machine-specific and deliberately not recorded here.

## 4. Environment / system state

- `#1` prerequisite `BinHsu/truewatch-ai-toolkit#2` closed 2026-08-24. `VERIFIED`.
- `BinHsu/dotClaude#11` **CLOSED completed** 2026-08-25T21:03:12Z via PR #13, merge SHA
  `cfe9fb7994a7cdd928e6650ac12f8b0247e80a56`. Settled form: See / verdict / edit in
  `ENGINEERING.md` "Handoff is git and only git". Consumer repos get a **pointer**. `VERIFIED`
  (`gh issue view 11 --repo BinHsu/dotClaude`).
- `#2` implemented as that pointer + `<!-- obligation:AG-GIT -->` + matching case.

## 5. Commands already run

```
bash bin/check --self-test
# SELF-TEST passed — 38 assertions

bash bin/check
# ✔ codex-budget — AGENTS.md is 13650 B, within 32768 B (41% used)
# ✔ case-correspondence — 2 obligations, 2 case entries (AGENTS.cases/), both directions match
# exit 0

python3 tests/test_evidence_artifacts.py --self-test
python3 tests/test_evidence_artifacts.py
```

## 6. Test results

| Check | Result |
|---|---|
| `bin/check --self-test` | pass, 38 assertions |
| `bin/check` | exit 0, AG-LAYER + AG-GIT 1:1, 13650 B / 41% |
| evidence validator self-test + run | pass (0 artifacts, vacuous) |

Earlier PR #3 CI (`32898894275`) was green for `#1` only. The `#2` commit needs its own PR CI watch
after push.

## 7. Current blockers, in priority order

None for `#1` / `#2` content. Merge of PR #3 is outward-facing (owner).

## 8. AWAITING DECISION — owner only

1. Merge [PR #3](https://github.com/BinHsu/aegis-template/pull/3)? After merge, watch the `main` CI
   run — a merge is a different run from the PR's.

## 9. Exact next safe action

```bash
gh pr view 3 --json state,mergedAt,url
```

If this commit is not yet on the remote, push `issue-1-three-layer-skeleton` and watch the new
`security-checks` run.

## 10. Things that will bite you

- **Do not copy the ENGINEERING.md See / verdict / edit table into this template.** `#11` put the
  body in one home. `#2` closes with a pointer. A second copy is the defect the issue named.
- **Do not copy toolkit-only `bin/check` clauses** (`git-hookspath`, `pattern-index`,
  `sibling-homes`, `tg-safety-docs`, `conventions-reachability`). This template does not contain
  those targets; a check against absent code is a check that cannot fail (`AGENTS.md` §12).
- **Do not wire `check_git_hookspath` into CI.** GitHub Actions checkouts do not set
  `core.hooksPath`; that clause would be permanently red on every PR.
- **Evidence correspondence ≠ rule↔case correspondence.**
- **`<!-- obligation:<ID> -->` examples must keep the angle brackets.** Measured 2026-08-26:
  `YOUR-ID` without brackets turned `bin/check` red on this branch.
- **`/bin/` in `.gitignore` would have dropped `bin/check` with no error.** The parent-directory
  exclude cannot be undone by a negation (`AGENTS.md` §7). Current pattern is `/bin/*` plus
  `!/bin/check`. If `git status` does not show `bin/check`, that is why.
