# `harness/` — the canonical record of the vendored `AGENTS.md` block

Two generated files, read by `bin/check-harness-block`. **Do not hand-edit either one**: edit
`AGENTS.md` inside the `<!-- harness:begin v=N -->` markers, then re-emit both.

| File | What it is |
|---|---|
| `AGENTS.harness.md` | The harness regions extracted from `AGENTS.md`, each preceded by `<!-- harness:region mode=exact\|prefix -->`. Generated; not loaded by any agent. |
| `HASH` | `version:` / `sha256:` / `source:` / `regions:`. The sha256 covers each region's mode and body in file order, not the comment lines. |

```
bin/check-harness-block --emit-canonical > harness/AGENTS.harness.md
bin/check-harness-block --emit-hash      > harness/HASH
bin/check-harness-block                  # must be green before you commit
```

Why this exists rather than an `@` import, why the audit only ever warns, and what the record
cannot tell you: `AGENTS.cases/AG-HARNESS.md`. The rule itself is `AGENTS.md`, section
"harness block".
