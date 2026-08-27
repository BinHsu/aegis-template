# Conventions — the things you use every session

**Division of labour: [`AGENTS.md`](AGENTS.md) holds the red lines — the things that get violated if
they are not written down. This file holds conventions — facts and agreements you reach for
constantly, but whose breach costs nothing immediately.**

**This file exists before you need it, on purpose.** `bin/check` measures `AGENTS.md` against Codex's
32 KiB project-doc budget, and overflow there is silent truncation. When that check goes amber, the
move is to layer content down to here — **not to delete a rule**. A repo that ships the alarm without
a destination pushes whoever hits it into deleting rules under time pressure, and that decision is
made with the least information anyone will ever have about which rule was load-bearing.

⚠️ **Layering is not retirement.** Moving prose here is a move; removing an obligation needs positive
evidence that the mistake it prevents can no longer happen, or that another rule now covers it in
full. See `AGENTS.md` for that bar.

## What belongs here

- How this project's tools are actually invoked — flags that bite, argument order, exit codes
- Where credentials live and how to point at the right environment
- Naming and file-layout agreements
- Third-party or platform behaviour you have measured and will hit again
- Anything you have explained to a newcomer more than once

## What does not

- **Obligations.** If breaking it causes harm, it is a red line and belongs in `AGENTS.md`.
- **Status.** That is `docs/handoff/CURRENT.md`, and only there.
- **Cross-project discipline.** That is `~/.claude/ENGINEERING.md`, which loads globally and must
  not be duplicated per repo.
- **Measured findings that deserve their own page.** Give those a file of their own; see
  `~/.claude/ENGINEERING.md`'s Records section for the routing.

## Delete this line and the sections you do not need

This file ships seeded, not blank, so that the first person to overflow the budget has somewhere
obvious to put things. If a section above is empty for your project, delete it — an empty heading
reads as "nobody has written this yet" and invites someone to fill it with the wrong thing.
