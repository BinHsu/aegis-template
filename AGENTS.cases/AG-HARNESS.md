<!-- case:AG-HARNESS -->
# AG-HARNESS — the copy is forced; trusting it is not

Layer-3 case for the `obligation:AG-HARNESS` anchor in `AGENTS.md`. **This file does not add an
obligation.** It holds why the block exists, why the audit may only shout, and the commands.

## 2026-09-16 supersession

The v2 draft uses two regions and preserves the non-mutating drift audit. Its first region ends at the repository-boundary introduction (prefix mode); the final maintenance region is exact. The section numbers below describe v1. Original grounds remain below as history.

## Why the content is duplicated at all

Claude Code expands `@AGENTS.md` from `CLAUDE.md`, and `~/.claude/CLAUDE.md` expands
`@ENGINEERING.md`. **Codex and Cursor expand neither.** `bin/check`'s own budget clause records the
upstream evidence: `codex-rs/core/src/agents_md.rs:162→180` has no `@` parsing on that path, so an
imported file's bytes never reach the model and nothing warns about it.

So harness policy cannot live once and be imported. Anything every scaffolded repo must obey has to
exist *physically* in that repo's `AGENTS.md`. The duplication is not a design choice to be tidied
away later — it is the price of the harnesses we actually use.

What *is* a choice is whether the copies are checked. A vendored copy with a checksum is ordinary
practice — `go.sum`, `git subtree`'s split marker, a lockfile. The only unusual part here is that
the carrier is Markdown, so the region boundary is an HTML comment.

## Why the audit may only shout, and never fix

🔴 **Drift is bidirectional, and the newer side is not reliably the template.**

Measured 2026-09-04 across three repos: a consumer repo's §12 ("A check that cannot fail
is worse than no check") had already been reduced to a six-line pointer at the `no-vacuous-checks`
skill, while this template still carried the full 26-line copy. **The consumer was newer.** An
auto-sync in either direction would have destroyed one of them silently: template→consumer would
have reinstated 26 stale lines, consumer→template would have been right that once and wrong the next
time by the same reasoning.

That is why there is no `--fix`, no `--apply`, and no hook that rewrites a block. The audit's whole
job is to make a human look at a diff. `--emit-canonical` and `--emit-hash` print to **stdout**;
the redirection a maintainer types is the deliberate act of blessing a version.

⚠️ The same incident is the reason the backflow went consumer→template in `BinHsu/dotClaude#34`'s
aegis-template PR: the good copy was in the consumer, and a person decided that, not a script.

## What the canonical record can and cannot tell you

`harness/AGENTS.harness.md` + `harness/HASH` travel *with* the copy. In a scaffolded repo they
therefore catch the common failure — somebody edited the block in place — and they structurally
cannot catch "upstream has moved on", because the baseline moved too.

**That second question is answered by running the audit from a fresh template clone against the
consumer's file**, which is the only reason `bin/check-harness-block` takes a path:

```
git clone https://github.com/BinHsu/aegis-template /tmp/tpl
python3 /tmp/tpl/bin/check-harness-block ~/some-consumer-repo/AGENTS.md
```

## Region modes, and why §9 is different

A region that stops at a section boundary is `exact` — the consumer's section must match byte for
byte. A region that stops *inside* a section is `prefix` — the canonical text must be the opening of
that section and the consumer may continue.

§9 is the reason the second mode exists. The tool-access table is identical in every repo; the list
of that repo's own destructive operations is not, and it belongs next to the table rather than in
§13 where nobody reads it before running a command. So the marker closes after
`Other agents: honour this table.` and everything the repo adds sits outside the block.
`bin/check-harness-block --self-test` asserts both halves of that: a tail added after the marker is
green, the same tail moved before it is red.

## Commands

```
bin/check                                  all three clauses, including this one
bin/check-harness-block                    audit this repo's own block
bin/check-harness-block <path/AGENTS.md>   audit another repo's copy
bin/check-harness-block --self-test        prove the audit still goes red and still goes green
bin/check-harness-block --emit-canonical   print the canonical (redirect to bless a new version)
bin/check-harness-block --emit-hash        print the HASH body for that canonical
```

Bumping `v=`: edit `AGENTS.md` inside the markers, re-emit **both** `harness/` files, and say in the
commit message which section moved and why. A version bump with no sentence explaining it is how a
consumer repo learns that it drifted but not whether it should follow.

## What this case must not become

A restatement of what the script does. If the script changes, this file's *reasoning* still holds; a
pasted copy of its behaviour would not.
