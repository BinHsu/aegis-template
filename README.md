# aegis-template

> **Secure-by-default starter scaffold.** A GitHub *template repository* (not a fork) — "Use this template" copies these files into a fresh repo with a clean first commit. Every new project starts with the security harness already baked in: the friction differential does the persuasion, not a checklist nobody reads.

## What's baked in

| File | Purpose | Harness practice |
|---|---|---|
| `CLAUDE.md` | Project-level agent rules. **References `~/.claude/CLAUDE.md` for cross-project disciplines** (does not duplicate them). | Rule layer |
| `AGENTS.md` | Multi-agent rules (Cursor / Devin / Copilot). Claude Code reads it via the `@AGENTS.md` import in `CLAUDE.md`. | Rule layer |
| `SECURITY.md` | The rules agents must not guess at — 4 categories: secrets, untrusted input, external actions, dependencies. | Rule layer |
| `.claude/settings.json` | Least-privilege tool access — allowlist + denylist (destructive commands default-deny). | Execution layer |
| `.claude/rules/` | Path-scoped rules, loaded on demand (e.g. terraform-only, tests-only). | Execution layer |
| `.github/workflows/security-checks.yml` | CI: secret scan + lint + (placeholder) benchmark. Security in the pipeline, not just review. | Verification layer |
| `.gitignore` | Defense-in-depth: `.env*`, secrets, `CLAUDE.local.md`, TF state, keys. | Execution layer |

The three layers map to the harness mental model: **Rule → Execution → Verification** (see `knowledge/harness_engineering_agent_security_7_practices.md` in the 2026Job repo).

## How to use

1. On GitHub: Settings → check **"Template repository"**.
2. New project → **"Use this template"** → fresh repo, clean history, harness inherited.
3. Fill the `{{PLACEHOLDER}}` spots in `CLAUDE.md` / `SECURITY.md` with your stack specifics.
4. Pick an archetype direction (stateless-sync / async-decoupled / stateful) and add the workload code.

## Relationship to the aegis archetype ecosystem

This is the **base scaffold** that the workload archetypes share. Specialise it:
- **stateless sync** (greeter-style) — Deployment, shared cluster, namespace isolation
- **async-decoupled** (enclave-style) — + SQS/queue compute decoupling
- **stateful** (statefulset-style) — StatefulSet + persistent storage

The platform substrate (landing-zone account fabric + platform tier) is consumed via a standard interface, so a workload can be promoted from shared-cluster to dedicated-cluster without rewriting its platform integration.

---

*v0 scaffold — refine per actual use.*
