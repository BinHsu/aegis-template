# aegis-template

> **Secure-by-default starter scaffold + DevSecOps reference implementation.** A GitHub
> *template repository* (not a fork) — "Use this template" copies these files into a fresh
> repo with a clean first commit. Every new project starts with the full security harness
> baked in: the friction differential does the persuasion, not a checklist nobody reads.

This is a complete implementation of the **Harness Engineering 7 security practices**
(see [`docs/SECURITY_PRACTICES.md`](docs/SECURITY_PRACTICES.md) for the per-practice
rationale; framework adapted from [Wisely Chen](https://ai-coding.wiselychen.com/harness-engineering-security-best-practices/)),
organized in three layers: **Rule → Execution → Verification.**

## The 7 practices → files in this repo

| # | Practice | Layer | Files |
|---|---|---|---|
| 1 | **Least-privilege tool access** | Execution | `.claude/settings.json` (allow/deny), `AGENTS.md` (3-way tool table) |
| 2 | **Security rules not buried mid-file** | Rule | `CLAUDE.md` (router, points to global), `SECURITY.md` at top; `scripts/audit-agent-compliance.sh` (monthly drift test) |
| 3 | **SECURITY.md pins the rules** | Rule | `SECURITY.md` (4 categories: secrets / untrusted input / external actions / dependencies) |
| 4 | **Sandbox isolation + review-feedback promotion** | Execution / Verification | `.githooks/pre-commit` (secret block), `.semgrep/` (promoted review rules), CI runs them |
| 5 | **Security in the benchmark, not just review** | Verification | `scripts/security-benchmark.py`, `scripts/cleanup-scanner.py`, `.github/workflows/security-checks.yml` |
| 6 | **Hidden destructive actions = product red line** | Rule / Execution | `PRODUCT_SENSE.md` (protocol), `scripts/safe-exec.sh` (preview→confirm→log→exec), `.agent-context/destructive-log.jsonl` |
| 7 | **Tool safety is production-grade** | Execution | `tools/registry.yaml` (single source of truth), `scripts/audit-tool-registry.sh` |

Cross-cutting: `docs/THREAT_MODEL.md` (Practice 3/4 — entry required for auth/crypto/payments/PII surfaces).

## What's runnable today (stack-agnostic)

- `python3 scripts/cleanup-scanner.py` — real secret-residue scan (exit 1 on finding)
- `bash scripts/safe-exec.sh rm -rf foo` — destructive-command preview + confirm + log
- `bash scripts/audit-tool-registry.sh` — tool-layer hole detection (needs `yq`)
- `.githooks/pre-commit` — enable with `git config core.hooksPath .githooks`
- CI (`security-checks.yml`) — wires cleanup-scanner + semgrep + registry-audit + benchmark

**Stubs to specialise per stack:** `security-benchmark.py` (3 baseline benchmarks are stubs),
the dependency-audit + lint steps in CI (uncomment the matching language), the
`{{placeholders}}` in `SECURITY.md` / `CLAUDE.md` / `THREAT_MODEL.md`.

## Cross-project rules live in `~/.claude/CLAUDE.md`

Language · date · bash · safety guardrails (a/h/i/k/m) · externalize-decisions ·
pre-push-diff · non-host-install · reusable-PII · AWS-tech-blog tone · subagent-delegation ·
no-hallucination — these load globally and are **not** duplicated in this template. The
template's `CLAUDE.md` points to them and `@import`s `AGENTS.md` (Claude Code does not read
AGENTS.md on its own).

## How to use

1. On GitHub: Settings → check **"Template repository"**.
2. New project → **"Use this template"** → fresh repo, clean history, full harness inherited.
3. `git config core.hooksPath .githooks` ; fill the `{{PLACEHOLDER}}` spots.
4. Pick an archetype direction (stateless-sync / async-decoupled / stateful), add workload code,
   wire the CI dependency-audit + lint steps for your language, specialise the benchmark stubs.

## Relationship to the aegis archetype ecosystem

Base scaffold the workload archetypes share. Specialise into:
- **stateless sync** (greeter-style) — Deployment, shared cluster, namespace isolation
- **async-decoupled** (enclave-style) — + queue compute decoupling
- **stateful** (statefulset-style) — StatefulSet + persistent storage

Platform substrate (landing-zone + platform tier) consumed via a standard interface, so a
workload promotes from shared-cluster to dedicated-cluster without rewriting its integration.

---

*DevSecOps reference implementation — v1. Specialise per actual use.*
