# Handoff — current state

> **This file is the single source of truth for project status.** If any other document disagrees
> with it, this one wins and the drift should be fixed. See `AGENTS.md` §3.

**Last updated:** 2026-08-26 — GitHub issue #1 transplanted locally; PR to `main` is the close.

---

## 1. Read these first

1. `docs/handoff/CURRENT.md` (this file)
2. `README.md`
3. `AGENTS.md`
4. `SECURITY.md`

You do **not** need any conversation history. If something here is unclear, that is a defect in this
file — fix it rather than guessing.

## 2. Last completed milestone

Three-layer rule-book skeleton is on branch `issue-1-three-layer-skeleton`: layer-1 preamble +
`<!-- obligation:AG-LAYER -->`, `AGENTS.cases/` with README + seed case, stripped `bin/check`
(Codex budget + obligation↔case), CI self-test-then-run.

| Commit | Content |
|---|---|
| `b7b2ded` | Add a per-file index, Codex-runnable acceptance criteria, and fix checks that could not fail |

## 3. Repository state

- Branch: `issue-1-three-layer-skeleton` (from `main` @ `b7b2ded`)
- Remote: `https://github.com/BinHsu/aegis-template.git`
- Visibility: public template repository
- Local path is machine-specific and deliberately not recorded here.

## 4. Environment / system state

- `#1` prerequisite `BinHsu/truewatch-ai-toolkit#2` is closed (completed 2026-08-24). `VERIFIED`.
- `#2` remains **OPEN** and **blocked** on `BinHsu/dotClaude#11` (no settled wording). Do not
  implement `#2` until that lands.

## 5. Commands already run

```
bash bin/check --self-test
# SELF-TEST passed — 38 assertions (B-1/B/B+1 on 85% band and 32 KiB cap; orphans red both ways)

bash bin/check
# ✔ codex-budget — AGENTS.md is 13371 B, within 32768 B (40% used)
# ✔ case-correspondence — 1 obligations, 1 case entries (AGENTS.cases/), both directions match
# exit 0

python3 tests/test_evidence_artifacts.py --self-test
python3 tests/test_evidence_artifacts.py
```

A first `bin/check` run went red because `AGENTS.cases/AG-LAYER.md` used `<!-- case:YOUR-ID -->`
in a how-to; that was harvested as a real anchor. Fixed to `<!-- case:<ID> -->`.

## 6. Test results

| Check | Result |
|---|---|
| `bin/check --self-test` | pass, 38 assertions |
| `bin/check` | exit 0, 1:1 AG-LAYER pair, 13371 B / 40% |
| evidence validator self-test + run | pass (0 artifacts, vacuous) |

CI on the PR has not been watched yet. Watch it after push.

## 7. Current blockers, in priority order

1. `BinHsu/dotClaude#11` unsettleed → `aegis-template#2` must not be copied yet.

## 8. AWAITING DECISION — owner only

None for `#1`.

## 9. Exact next safe action

After this branch is committed and pushed:

```bash
gh pr create --base main --title "Add three-layer rule-book skeleton and orphan-refusing checker" --body 'Closes #1'
gh run watch --exit-status
```

Do **not** start `#2`. Stay on this repo.

## 10. Things that will bite you

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
