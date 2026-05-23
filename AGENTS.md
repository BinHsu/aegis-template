# AGENTS.md

> Tool-agnostic agent rules (Cursor / Devin / Copilot / others). **Claude Code reads
> this via the `@AGENTS.md` import in `CLAUDE.md`** — Claude Code does not load AGENTS.md
> on its own. Cross-project safety guardrails live in `~/.claude/CLAUDE.md`.

## ⚠️ Read first

1. `SECURITY.md` — security rules you must not guess at.
2. This file — tool-access + destructive-action protocol.
3. `CLAUDE.md` — repo-specific context.

## Tool-access classification (least-privilege)

| Class | Examples | Handling |
|---|---|---|
| **Read-only** | grep, find, read file, `curl GET`, `psql SELECT` | auto-allow |
| **Write** | edit file, `git add/commit`, `npm install` | allow + audit log |
| **Destructive** | `rm -rf`, `git push --force`, `git reset --hard`, `drop table`, `kubectl delete`, `terraform apply/destroy` | default-deny, explicit approve each time |

Enforced for Claude Code in `.claude/settings.json` (allow/deny lists). Other agents:
honour this table.

## Destructive-action protocol

A destructive action removes data, overwrites without backup, or changes state visible
to other users. For every one, you MUST:
1. Print a clear preview: "About to delete/overwrite X, Y, Z. This is irreversible."
2. Stop and wait for the user to type **`confirm`** (not "ok" / "yes").
3. Log to `.agent-context/destructive-log.jsonl` BEFORE executing.
4. If not confirmed in the same turn, abort.

**Destructive actions must never be hidden.** A "done" that quietly deleted files, or a
default-destructive script that needs `--dry-run` to preview (order reversed), is a
product red line. The full rationale + red-line list is in `PRODUCT_SENSE.md`; route
destructive shell commands through `scripts/safe-exec.sh` (preview → confirm → log → exec).

## Workflow

1. Plan → write proposed changes before editing.
2. Confirm with the user before destructive or wide-blast-radius edits.
3. Execute in small commits.
4. Before commit + push: present a diff summary of what changed (cross-project rule).
