# CLAUDE.md — {{PROJECT_NAME}} (project-level rules)

> **Cross-project disciplines (language, date, bash, safety guardrails a/h/i/k/m,
> externalize-decisions, pre-push-diff, non-host-install, reusable-PII, no-hallucination)
> live in `~/.claude/CLAUDE.md` and load globally — they are NOT repeated here.**
> This file holds only what is specific to THIS repo.

@AGENTS.md

## What this repo is

{{ONE_PARAGRAPH — what this service/project does, its archetype (stateless-sync /
async-decoupled / stateful), and its calibration (e.g. "production-shape at PoC scale").}}

## Files and their roles

{{TABLE — key files + what each is for. Keep it a map a new agent can navigate from.}}

## Where to start (by role)

- **First-time reader:** README → SECURITY.md → this file → `docs/` design notes.
- **Code review / audit:** SECURITY.md → the diff → tests.
- **Before any destructive action:** `PRODUCT_SENSE.md` (red lines) + `scripts/safe-exec.sh`.
- **Conflict-resolution rule:** if this file and a doc disagree, the more-recent /
  more-specific wins; flag the drift rather than silently picking one.

## Repo-specific rules

{{Add only repo-specific constraints here, e.g.:
- public/private boundary (which buyer/private names must NOT appear in committed files)
- archetype-specific isolation posture (namespace vs node-group vs dedicated cluster)
- domain conventions (ADR numbering, runbook format, etc.)
Anything cross-project belongs in ~/.claude/CLAUDE.md, not here.}}

## ADR conventions (if this is a build repo)

Decisions recorded as ADRs under `docs/ADR/` (MADR format — context / options /
decision / consequences). Deleted/superseded ADR numbers are left as gaps (receipts of
human iteration); `docs/ADR/INDEX.md` routes by reader goal.
