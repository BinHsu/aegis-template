<!-- case:AG-LAYER -->
# AG-LAYER — the three-layer split itself: why it is cut this way, and how to maintain it

Layer-3 case for the `obligation:AG-LAYER` anchor in `AGENTS.md`. **This file does not add an obligation.**

This is the seed pair this template ships so a new repo is born with a visible shape, not only an empty checker. Numbered sections in `AGENTS.md` (§1–13) are **structural headings, not obligation IDs.** Adopt three-layer for a further rule by adding `<!-- obligation:<ID> -->` and a matching case in the same change; `bin/check` turns red on orphans.

## The starting point is layering; the budget is a catalyst (owner, 2026-08-23)

> The starting point is one thing: we need the concept of layers. **What the model reads is a boundary, and it must keep doubting**, then know where the directory is, and knowing the directory how to **open only the associated** case.

**Shrinking the file is not this work.** Cutting without telling the model it is reading an excerpt produces a **more confident, more often wrong** reader — that is the difference between layering and slimming. Layer 1 has to do two things at once: **block a violation** (safe even if nothing below is opened) **and let the reader know it is incomplete**.

## Acceptance per layer

| Layer | Contents | File | This layer's own acceptance |
|---|---|---|---|
| 1 | Trunk and basic rules — MUST / MUST NOT + criteria + the intuition you were about to obey | `AGENTS.md` | Blocks a violation without looking down **and** the reader knows this is a boundary and where the case lives |
| 2 | Directory — obligation anchor → case location | **the anchor ID itself** (`AGENTS.cases/README.md` is explanation only) | From one rule, open only that rule's case; no scan of the others |
| 3 | Cases — events, dates, measurements, rejected options, intent, rationale | `AGENTS.cases/<ID>.md` | A case may be long, because it is read on demand |

## Why layer 2 is a filename, not an index file

**Acceptance is "only the relevant files were read", not "they can be found".** An index the model has to finish before it knows which case is relevant **is not layering** — the cost is one full read becoming two.

Push the mapping into the **filename** and the selection cost is zero: seeing `<!-- obligation:AG-LAYER -->` means `cat AGENTS.cases/AG-LAYER.md`, with nothing in between to read.

`bin/check` verifies the invariant: **every `<!-- case:<ID> -->` must live in `<ID>.md`.**

The angle brackets on `<ID>` in that sentence are required, not decoration: the extractor demands that an ID start with `[A-Za-z0-9]`, and `<` does not. Drop the brackets and this explanation file becomes an orphan case pointing at `ID.md`, and the check goes red.

IDs are mnemonic (`AG-LAYER`), not positional (`7.`, `7.1.`). Positional numbers cascade-fail every later item on insert or delete, which is how people start skipping the check.

## Why layer 1 must stand alone (harness trigger mismatch)

| harness | Mechanical (non-discretionary) on-demand mechanism | Trigger |
|---|---|---|
| Claude Code | `.claude/rules/*.md` `paths:` glob | Opening a matching file |
| Cursor / Grok | `globs` auto-attached | Same |
| **Codex** | **nested `AGENTS.md`** | **cwd** |

All three mechanical mechanisms fire on **location**. Layers 2 and 3 in this design fire on **doubt**. Codex has no topic-triggered discretionary load either. So layer 1 "safe without looking down" is the safety net, not a bonus. Mapping layers onto directory structure was rejected: cases are split by **rule**, not by **which directory you are editing**.

## Byte budget (the catalyst half)

Codex's project-doc budget (read from `openai/codex@main`, 2026-08-23):

- One pool for the tree, not one per file
- Root is consumed first
- Overflow is **silent truncate**
- After the pool hits zero, later files are not opened

`bin/check` `codex-budget` measures **repo-root** `AGENTS.md` / `AGENTS.override.md` against 32 KiB, with an 85% warn band that exits 3 rather than 0. A missing `AGENTS.md` is red — that is not "nothing to check". `@`-imports are named and **not** counted: Codex does not expand them.

A budget warning may trigger **layering** (move non-obligation text into a case). It must not trigger **retiring an obligation**. The same rule must have the same answer at 29 KB and at 32.7 KB.

## This is not the evidence-artifact checker

`docs/validation/evidence/REQUIRED.json` + `tests/test_evidence_artifacts.py` already correspond a manifest to per-item files, pass when the list is empty, and prove they can fail with `--self-test`. That mechanism records Group B observations. This mechanism corresponds layer-1 obligations to layer-3 cases. Two shapes, two jobs. Do not invent a third JSON manifest for cases.

## How to add another obligation

1. Write the MUST / MUST NOT + criterion + misleading-intuition line in `AGENTS.md`, with `<!-- obligation:<ID> -->`.
2. In the same change, add `AGENTS.cases/<ID>.md` with `<!-- case:<ID> -->`. Put history here, not a new rule.
3. Add both paths to `docs/FILE-MAP.md` in that same change.
4. Run `./bin/check`. Orphans are red both ways.

## Rejected options

| Option | Why not |
|---|---|
| Convert every existing `AGENTS.md` §1–13 heading into an obligation ID in the same transplant | Those headings are structure, not one-rule-one-ID. Mixing them produces a cascade of case files that restates the template instead of seeding the shape. |
| Ship `bin/check` with both sides empty and no seed pair | Vacuous green is correct for "not adopted", but a new repo would have the checker and no example of an obligation. This template already seeds one example phase in `REQUIRED.json`; the seed pair here is the same idea. |
| Copy toolkit-only clauses (hooksPath, sibling routing, Telegram, conventions.md) | Those targets are not in this scaffold. A check against absent code cannot fail (`AGENTS.md` §12). `core.hooksPath` is also unset in GitHub Actions, so that clause would be permanently red in CI. |
| A JSON manifest of obligation IDs | The filename *is* the mapping. A second list is a second thing to rot. |
