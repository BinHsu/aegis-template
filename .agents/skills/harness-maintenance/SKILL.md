---
name: harness-maintenance
description: Maintain this repository's vendored harness, policy-case mapping, security wrappers and evidence records. Use for policy/scaffold changes, not ordinary coding or session startup.
---

# Harness maintenance

The root AGENTS.md and SECURITY.md own permissions. This procedure does not grant
publication, destructive cleanup or customer access.

## Policy and canonical changes

Read the relevant case and identify the safety effect before changing a rule.
Preserve that effect in standing policy or an enforcement mechanism; remove redundant
general coaching rather than moving every paragraph into mandatory references.
Cases and conventions explain current policy and cannot secretly alter authority.
Historical claims may remain with an explicit supersession note.

The marked text is a reviewed shared baseline, not a template-wins instruction.
Compare template and selected consumer, settle actual semantic differences, bump every
region's version together and inspect the proposed diff. The existing emitter prints
the two generated records:

```sh
python3 bin/check-harness-block --emit-canonical
python3 bin/check-harness-block --emit-hash
```

Update `harness/AGENTS.harness.md` with the first output before generating the second
for `harness/HASH`. Deliberately transfer the reviewed records to selected consumers.
Do not add automatic synchronization. Verify both the source and consumer with:

```sh
python3 bin/check-harness-block --self-test
python3 bin/check-harness-block
python3 bin/check-harness-block <consumer-checkout>/AGENTS.md
```

`bin/check --self-test` exercises budget/case/drift checks. Read its current clauses
before running an unscoped check: consumer repositories can add checks that inspect
siblings or networks. A structural pass does not establish complete policy compliance.
Add new tracked paths to `docs/FILE-MAP.md`; this is discovery, not live status.

## Evidence and decision artifacts

An accepted architecture decision belongs in `docs/ADR/` with context, options,
decision, consequences and a re-check trigger where a premise can change.
Keep undecided proposals in design/task records, clearly labeled; do not invent owner approval.
Preserve old decisions with dated supersession instead of silently replacing their meaning.

When the consumer schema requires evidence tags, use:
`VERIFIED` (direct observation with command/output), `CROSS-CHECKED` (independent
corroboration), `INFERRED` (reasoned only), `BLOCKED` (external dependency),
`COMMUNITY` (unestablished third-party report), `NO-EVIDENCE-FOUND` (named places
searched), or `UNVERIFIED` (not established). No negative search or documentation
claim is a passing runtime test. Ordinary replies need truthful wording, not a fixed tag format.
`docs/design/acceptance-criteria.md` and `docs/validation/evidence/REQUIRED.json`
describe machine-auditable human observations; schema validity does not prove the observation.

## Destructive wrapper changes

`scripts/safe-exec.sh` receives an executable plus separate arguments, previews them
without evaluation, asks for literal `confirm`, logs before execution, then invokes
the original argv. It intentionally gates every call: pattern matching is not a general
destructive-operation detector. Do not pipe an agent-generated confirmation into it.
A human-approved wrapper run still needs resolved targets and an accurate recovery statement.
Test in a temporary directory; never test the wrapper with real user/customer data.
