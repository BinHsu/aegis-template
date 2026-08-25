<!-- This file carries no case: anchor. It is not a case; it is this layer explaining itself. -->
# Layer 3: cases

**Each file here corresponds to one obligation in `AGENTS.md` (layer 1). The filename is that obligation's anchor ID.**

    AGENTS.md   <!-- obligation:<ID> -->   →   AGENTS.cases/<ID>.md

**So there is no index to read.** Start from a rule, open only that one file. You do not scan the other cases, and you do not read a directory first to pick. An index you have to finish before you know which file is relevant is not layering — it is reading everything twice.

Keep the angle brackets in examples like `<!-- obligation:<ID> -->`. `bin/check` requires the first character of an ID to be `[A-Za-z0-9]`; `<` is what stops this README from becoming an orphan case.

## What this layer holds

Events, dates, measurements, **rejected options and why they were rejected**, intent (the half that is not in the wording), rationale. **A case may be long, because it is read on demand.**

## What this layer must not hold — obligations

**A case must not add, relax, or tighten any obligation.** An agent that never looks down must still be able to keep every rule (`AGENTS.md` is the safety floor). An obligation written only here is an obligation that agent never sees. New obligations go in layer 1; this layer explains why they exist.

## Mechanical guarantee

`bin/check` `case-correspondence` verifies both directions:

- Every obligation anchor in `AGENTS.md` has a matching case, and vice versa (orphans are red both ways).
- **Each case anchor must live in a file named `<ID>.md`** (sub-number `ID.1` lives in `ID.md`).
  Without that, "the filename is the location" is something a person has to remember — which is how an index rots.

Both sides empty is green: the split is not adopted yet, not broken. That is a different correspondence mechanism from `docs/validation/evidence/REQUIRED.json` (Group B artifacts). Do not merge the two.
