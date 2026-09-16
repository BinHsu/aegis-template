# Personal harness review — aegis-template, 2026-09-15

Review only; not an accepted decision or active instruction. Source baseline:
BinHsu/aegis-template@9f601b6, main, clean and equal to origin/main after fetch.
The primary agent personally read the policy, canonical payload, three obligation
cases and supporting documents. This public repository was not published to.

## Outcome

Keep a small portable safety/ownership contract and real executable checks. Do
not make every new project inherit a second global workflow. The existing
byte-consistency mechanism works for the tested mutations, but consistency does
not establish semantic correctness. In particular, the copied CURRENT.md contract
conflicts with the installed global git-only contract.

`KEEP` means preserve the standing effect, not the current length. `SPLIT` keeps
the boundary and moves the named procedure. `SKILL` is demand-loaded procedure;
`TOOL` is deterministic enforcement. `FIX` means resolve contradictory or
unsupported wording. `EVAL` is a candidate technique change, not authorized removal.

## Clause review

Ranges are local AGENTS.md sections/anchors at the baseline; shared content was
also read in harness/AGENTS.harness.md. A shared paragraph is reviewed once here,
not counted as a second independent finding in the consumer.

| ID / source | Intended effect | Disposition and reason |
|---|---|---|
| T01 banner / global-policy reader | Same boundaries reach different agents | KEEP minimal adapter and fail-closed required read. TOOL test missing imports/cycles/read errors. Do not expose every Claude-specific mechanic to all other agents just to load global policy. |
| T02 Read first | Cold reader finds purpose, safety and live work | FIX CURRENT-first versus global README-first; SKILL task-specific orientation rather than unconditional full onboarding. |
| T03 cold-reader paragraph | Durable facts survive a session | KEEP recoverability. “Not written does not exist” must mean unavailable evidence, not denial of directly observed state. |
| T04 FILE-MAP pre-create | Avoid duplicate files; maintain discovery | TOOL manifest validation + contributor skill. KEEP short pointer if this manifest remains maintained; no need for a long universal explanation. |
| T05 AG-LAYER scope | Standing file alone defines safety | KEEP. Cases may explain, never secretly change permission. Classify by effect rather than filename. |
| T06 AG-LAYER correspondence/budget | Detect orphan cases and payload size | TOOL; a mapping test only validates mapping, not semantic completeness or actual loaded context. Default/configured byte budget must be distinguished from model token capacity. |
| T07 AG-LAYER overflow | Preserve obligations instead of deleting to satisfy a size check | KEEP safety-effect preservation. EVAL blanket mandatory conventions destination: compulsory reading moves bytes, not instruction load. First retire duplicates and separate triggered procedure. |
| T08 AG-LAYER case triggers | Know original intent before changing a rule | KEEP for policy changes; SKILL review procedure. Do not recursively load every historical reference unrelated to the change. |
| T09 AG-GIT | Global scope rule has one home | KEEP short pointer. It cannot coexist coherently with the competing status ownership in §3–4. |
| T10 AG-HARNESS exact copy | Detect edits that drift from a reviewed baseline | TOOL + short maintainer contract. Preserve non-mutating audit. “No @ expansion” alone does not prove physical duplication is the only possible delivery mechanism; explicit readers already exist. |
| T11 AG-HARNESS no auto-sync | Do not overwrite a newer consumer with stale template | KEEP. Upstream update is a reviewed change, not a blanket template-wins repair. |
| T12 §1 What this repo is | Repo-specific purpose | KEEP short filled-in context. A scaffold placeholder is not a deployed project's architecture. |
| T13 §2 Files and roles | Navigation to actual working objects | TOOL/README map. Remove capability status from this list; status claims here contradict §3 even before they become stale. |
| T14 §3 sole CURRENT status | Avoid conflicting status copies | FIX with global git-only policy. Choose authority once. Existing evidence remains historical; do not delete its content merely because the carrier changes. |
| T15 §3 required fields/runnable next action | Actionable handoff | SKILL handoff template. A placeholder command is not runnable; next action must be scoped to the actual task, not an old agenda. |
| T16 §4 pre-risk handoff | Survive process/session death | KEEP property; TOOL durable execution receipt and SKILL recovery plan. EVAL commit before and after every meaningful segment regardless of risk. |
| T17 §5 evidence tags | Distinguish observed, inferred, unknown and searched-negative | KEEP truthfulness; SKILL/TOOL typed artifact schema when consumed. Not every ordinary sentence needs one of seven tags. |
| T18 §5 COMMUNITY/CROSS-CHECKED | Distinguish source authority from independent corroboration | SKILL evidence method. A vendor statement is not a runtime observation; independent agreement is not automatic proof either. |
| T19 §5 Group B artifact | Human observation can be recorded and audited | TOOL schema + task acceptance skill. Validate existence/fields separately from truth of the observation. |
| T20 §5 candidate move note | Track intended global promotion | Reference/issue, not permanent startup policy. This dated status note violates global temporary-note discipline. |
| T21 §6 accepted ADR only | Do not present proposals as accepted decisions | KEEP decision integrity. FIX “decisions belong to owner” if interpreted as forbidding ordinary authorized implementation choices. Preserve owner-owned trade-offs. |
| T22 §6 format/index/addendum | Durable rationale without silent rewriting | KEEP no silent record replacement; SKILL architecture decision record format and index maintenance. |
| T23 §7 credentials/private machine data | No sensitive or nonportable content in git | KEEP data boundary; TOOL scanning/allowlists. Separate public certificates/fixture values from secrets by explicit schema instead of treating every certificate as secret. |
| T24 §7 binaries/builds/gitignore negation | Keep derived output out; avoid ineffective allowlist | TOOL ignore/allowlist and contributor skill. Binary format is not itself a privacy category; intentional assets need an explicit exception policy. |
| T25 §8 milestones | Continue authorized work, not stop for ceremony | KEEP one pointer to global autonomy. FIX CURRENT deferral carrier if global status authority wins. Finishing the requested scope remains legitimate. |
| T26 §9 read/write/destructive classes | Least privilege | KEEP effect-based boundary. FIX command-name-only classification: an HTTP GET can incur cost/disclose data and npm install can execute third-party code. Config is not proof the gate is active for all agents. |
| T27 §9 repo tail | Domain-specific permission limits adjacent to common contract | KEEP actual filled-in boundary. Placeholder text cannot be treated as implemented protection. |
| T28 §10 preview/confirm/log/abort | No hidden destructive action | KEEP explicit target and consent intent; TOOL transaction-bound confirmation and pre-execution audit. Clarify “same turn” across asynchronous user replies and typed scripts rather than relying on prose timing. |
| T29 §10 all externally visible changes destructive | Outbound operations gated | FIX taxonomy, not permission: separate reversible edits, external publication and irreversible destruction. Otherwise every ordinary remote action inherits literal confirm and conflicts with standing private-report consent. |
| T30 §11 plan/confirm/commits/summary/test | Reviewable, scoped and checked change | KEEP relevant verification and approval; SKILL workflow. EVAL mandatory formal plan/diff table for every trivial edit. |
| T31 §12 no vacuous checks | Passing check actually exercises its claim | KEEP short principle; TOOL positive/negative fixtures; no-vacuous-checks skill already is a good split. |

## Supporting sources and case review

| Source | Judgment |
|---|---|
| CLAUDE.md | Keep import and actual Claude-only mechanics. Delegation, visible scope, commit discipline and conflict precedence are not Claude-only and should not have a second home here. |
| conventions.md | Useful destination only for demand-loaded context. Its header cannot guarantee that future additions lack obligations; inspect semantics. No blanket read-every-session expansion. |
| SECURITY.md | Preserve actual approval and secret/trust boundaries; merge duplicate consent rules with §9–10. A textual untrusted delimiter is guidance, not a sandbox. Dependency audit recipes belong to a skill/check. |
| PRODUCT_SENSE.md | Preserve no-hidden-destruction product requirement. Repeated four-step protocol should reference one authority. The approximate 90% incident-prevention claim is not demonstrated by this review and should not be used as evidence. |
| README.md | Setup and entrypoints belong here; distinguish shipped scaffold from working protection. Do not auto-run every example as an instruction. |
| docs/handoff/CURRENT.md | Read as historical/current-state evidence, not authority to resume unrelated work. Its pending harness work predates already-merged main; placeholder PR-number command is not an exact next safe action. No history was erased. |
| AGENTS.cases/AG-LAYER.md | Preserve safe-without-history intent and reasons for correspondence; dated model/loader claims require current verification before reuse. Cases should not become permission overrides. |
| AGENTS.cases/AG-GIT.md | Supports one home for scope; does not settle competing CURRENT status text automatically. |
| AGENTS.cases/AG-HARNESS.md | Preserve bidirectional drift evidence and distinction between local canonical integrity versus upstream currency. Delivery mechanism rationale is narrower than “all alternatives impossible.” |
| harness/AGENTS.harness.md | Generated evidence of the selected template, not another policy authority. Do not manually edit. A correct hash can preserve a conflicting rule perfectly. |

## Evidence

Used the no-vacuous-checks skill before relying on this test. Read
bin/check-harness-block before execution. Commands run from this repository:

```
python3 bin/check-harness-block --self-test
python3 bin/check-harness-block <inventory-checkout>/AGENTS.md
```

Self-test: exit 0, **16 assertions all as expected**, with real text mutation
returning 1 and missing/bad canonical record returning 2. Consumer audit: exit 0,
four regions, 13 sections, digest prefix bddce25cfd0c. This is evidence of copy
agreement and the tested checker responses, not enforcement in every harness.
No live destructive operation, paid agent probe or broad security benchmark ran.

## Open item disposition and handoff

BinHsu/aegis-template#9 remains open. Its benchmark complaint is relevant to the
distinction between scaffolding and assurance; this review did not execute or
repair that benchmark and does not revalidate its old issue description. No open
PR was present at the initial fetch. No issue state was changed.

Only this report and its FILE-MAP entry were added. No active policy/canonical
content changed. Local-only review: no commit, push or public PR. Proposed next
implementation dependency is to settle global versus scaffold authority before
rewriting the canonical and consumer together. The larger comparison belongs to
BinHsu/dotfiles, docs/reviews/2026-09-15-harness-review.md.


## 2026-09-16 completion and publication preparation

The owner explicitly requested completing the remaining fixes, committing and
pushing this harness batch. Scope is BinHsu/aegis-template and
BinHsu/truewatch-topic-inventory on main. Both remotes were fetched and both
branches matched origin/main before implementation. This supersedes the earlier
local-only scope and the pending template migration; no unrelated workload,
customer operation, paid run, ticket transition or cleanup is included.

The template now carries the maintenance skill, an exact-file gitignore exception,
v2 canonical/hash and repaired checker fixtures. Source and selected consumer
share the same canonical digest `9f60cf9286f21b5a455edb1f1dc1a7d9f9acc15273fd85c05f18daa41af84775`.
README/FILE-MAP/historical handoff routing is consistent, and PRODUCT_SENSE points
to the current consent contract while explicitly superseding its unsupported
percentage and same-turn restriction.

Review also found that the preexisting safe-exec implementations contradicted the
v2 argv contract. Both wrappers now gate every invocation, display escaped argv
without running a preview program, require literal confirm, serialize/fsync JSON
before execution, abort on logging error and execute original argv without eval.
A command string is no longer interpreted as shell syntax. Explicit shells still
execute code by design; this wrapper is not a sandbox or an authorization source.
The threat model and file map describe this boundary. No caller code was migrated;
repository references use separate executable/arguments or historical examples.

Verification:

- Each wrapper passes 10 temporary-directory tests with zero skips. Inventory's
  report used its existing test venv, Python 3.12.13, through `bin/run-tests`.
- Against each repository's original HEAD wrapper in an isolated temporary tree,
  all three selected regression cases fail: unclassified-command confirmation,
  literal argv/log-before-child, and refusing execution after logging failure.
  Each old implementation produced 3 assertion failures and 0 test errors.
- Template `bin/check --self-test`: 41 assertions pass. Harness self-test: 16 pass.
  Template `bin/check`: all 3 checks pass. Template-to-inventory audit passes.
  Inventory's earlier 76 checker assertions and 16 harness assertions remain valid;
  those checker files have not changed since that verification.
- Template `bin/test --strict`: 2 clean suites, 1 suite with a skip, 0 failed suites;
  overall exit 1 because evidence well-formedness has 0 artifacts. This is a known
  scaffold coverage limit, not a verified observation and not replaced with fake data.
  Evidence validator self-test passes 12 cases (10 negative).
- All three skill directories pass quick_validate using the existing inventory
  venv. System Python lacked PyYAML; no dependency was installed.
- Template skill ignore checks admit only the named SKILL.md and keep sibling
  agent state ignored. Template secret scanner and diff whitespace checks pass.

Publication results are verified against remote main after push and reported with
repository-qualified commit IDs; this preparation record does not itself claim
that publication has already occurred. Application/runtime behavior and the
empty scaffold evidence scope remain outside the verification claim.
