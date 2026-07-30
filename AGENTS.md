# AGENTS.md — operating contract for {{PROJECT_NAME}}

> **This is the primary policy file for every agent and human working here** — Claude, Codex, Grok,
> Cursor, Devin, Copilot, people. `CLAUDE.md` imports this file on its first line and holds nothing
> but Claude-specific mechanics, because Claude Code does not read `AGENTS.md` on its own.
>
> Cross-project safety guardrails for this machine live in `~/.claude/CLAUDE.md`.

## ⚠️ Read first, in this order

1. **`docs/handoff/CURRENT.md`** — where the previous worker stopped and the exact next safe action.
2. `README.md` — what this repo is.
3. `SECURITY.md` — security rules you must not guess at.
4. This file — safety gates, tool-access classes, destructive-action protocol.

**Assume the next worker has no access to any chat history.** The repository on disk and on its
remote is the single source of truth. If a fact is not written down, it does not exist.

---

## 1. What this repo is

{{ONE PARAGRAPH — what this service/project does, its archetype (stateless-sync / async-decoupled /
stateful), and its calibration, e.g. "production-shape at PoC scale".}}

## 2. Files and their roles

{{TABLE — key files and what each is for. Keep it a map a new agent can navigate from.}}

## 3. Single source of status

**`docs/handoff/CURRENT.md` is the only place project status is written.** Not the README, not a docs
index, not a comment in a header, not this file.

**Do not add a status summary anywhere else, however convenient it seems.** Status duplicated in a
second file drifts within days, and a confidently stale "nothing has been done yet" banner is worse
than no banner at all — it can send the next worker to redo destructive work, or to distrust results
that are actually sound. If you find another file stating status, delete that statement and replace
it with a link.

`docs/handoff/CURRENT.md` must always contain: last completed milestone; current branch and commit;
environment state; commands already run; test results; current blockers; anything `AWAITING
DECISION` by the owner; and the **exact next safe action** as a runnable command.

Write it vendor-neutral. Never "as we discussed", never a reference to a conversation. Write for a
stranger.

## 4. Handoff protocol — write it BEFORE the risky thing

The failure mode to survive is **an agent dying mid-operation**: session limit, API error, crash,
context exhaustion.

- **Write the handoff before starting a long or risky operation, not after.** State what you are
  about to do, the exact command, and where the next worker resumes if you never return. Commit it.
  Then do the thing. Then update with the result.
- A post-hoc-only handoff is worthless precisely when it is needed, because the crash happens
  *during* the operation and the update never runs.
- Update after every meaningful segment — not only at milestones, and not only when you sense a
  limit approaching.

## 5. Evidence standard

Every capability claim carries a tag for how it is known. Never promote a tag without new evidence.

| Tag | Meaning |
|---|---|
| `VERIFIED` | Observed directly; cite the command and its output |
| `CROSS-CHECKED` | An independent source or implementation agrees |
| `INFERRED` | Reasoned but not observed — **may not be reported as working** |
| `BLOCKED` | Waiting on something external |
| `UNVERIFIED` | Not established. Treat as unknown, not as "probably fine" |

An `INFERRED` row is never a passing test. "It should work" and "the docs say it supports this" are
both `INFERRED`.

## 6. Decision records

- A decision enters `docs/ADR/` **only once made and backed by evidence.** MADR format: context /
  options / decision / consequences. Add a **re-check trigger** where the decision rests on
  something that may change.
- Anything still open goes in `docs/design/` or `docs/handoff/CURRENT.md`, marked `AWAITING
  DECISION`. Decisions belong to the owner; agents propose.
- Never silently rewrite a decision. Supersede it with a new dated record that links back, or add a
  dated addendum. Deleted/superseded numbers are left as gaps — they are receipts of human iteration.
- `docs/ADR/INDEX.md` routes by reader goal.

## 7. Never commit

Enforced by `.gitignore` and `.githooks/pre-commit`, but keep the rule regardless:

- Credentials of any kind, `.env` files, private keys, certificates
- Absolute filesystem paths, hostnames, serial ports, anything machine-specific. Use an
  `.env.example` plus a gitignored local file.
- Build output and binaries
- **Git history is not erasable.** Treat every commit as though the repository were already public,
  because private repositories become public and forks outlive deletions. If a class of file is
  sometimes safe and sometimes not, ignore the class and allow-list the known-safe member rather
  than trusting anyone to remember the difference. Note the git gotcha this depends on: a negation
  cannot re-include a file whose *parent directory* is excluded, so ignore `dir/*`, not `dir/`.

## 8. Milestones are checkpoints, not stop signs

Finishing a milestone means: update docs, run tests, commit — then keep going. Stop only when an
operation is irreversible or outward-facing, when a decision genuinely requires the owner, or when
you are blocked by missing information.

Do not stop to ask whether to continue. Do not narrow scope to save effort. If you must defer
something, name it explicitly in the handoff.

## 9. Tool-access classification (least-privilege)

| Class | Examples | Handling |
|---|---|---|
| **Read-only** | grep, find, read file, `curl GET`, `psql SELECT` | auto-allow |
| **Write** | edit file, `git add/commit`, `npm install` | allow + audit log |
| **Destructive** | `rm -rf`, `git push --force`, `git reset --hard`, `drop table`, `kubectl delete`, `terraform apply/destroy` | default-deny, explicit approve each time |

Enforced for Claude Code in `.claude/settings.json`. Other agents: honour this table.
{{Add any repo-specific destructive operations here — e.g. writing device flash, transmitting on a
radio, sending an outbound message. If an operation is irreversible or visible to others, it is
destructive regardless of how small the command looks.}}

## 10. Destructive-action protocol

A destructive action removes data, overwrites without backup, or changes state visible to others.
For every one you MUST:

1. Print a clear preview: "About to delete/overwrite X, Y, Z. This is irreversible."
2. Stop and wait for the owner to type **`confirm`** (not "ok" / "yes").
3. Log to `.agent-context/destructive-log.jsonl` BEFORE executing.
4. If not confirmed in the same turn, abort.

**Destructive actions must never be hidden.** A "done" that quietly deleted files, or a
default-destructive script that needs `--dry-run` to preview (order reversed), is a product red
line. Full rationale and red-line list in `PRODUCT_SENSE.md`; route destructive shell commands
through `scripts/safe-exec.sh` (preview → confirm → log → exec).

## 11. Workflow

1. Plan → write proposed changes before editing.
2. Confirm with the owner before destructive or wide-blast-radius edits.
3. Execute in small commits.
4. Before commit + push: present a diff summary table of what changed and why.
5. After editing, run the check that would catch the mistake — type-check, lint, test. Bytes written
   is not a passing test.

## 12. Repo-specific rules

{{Add only repo-specific constraints here, e.g.:
- public/private boundary — which names must NOT appear in committed files
- archetype-specific isolation posture (namespace vs node-group vs dedicated cluster)
- hard safety gates unique to this domain
Anything cross-project belongs in `~/.claude/CLAUDE.md`. Anything Claude-specific belongs in
`CLAUDE.md`. Delete this section if it stays empty.}}
