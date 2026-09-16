# Product principle: no hidden destructive actions

Destruction must never be a surprising side effect. A control labelled "Optimize"
must not silently truncate a table, and an agent must not report completion while
quietly deleting files. Preview must be the default for a destructive tool;
execution needs an explicit action.

Follow AGENTS.md's "Permissions and destructive actions" contract for exact targets,
recoverability, confirmation and pre-execution logging. Outbound publication and
paid operations require their own current consent; they are not automatically
irreversible destruction. Confirmation may arrive in a subsequent reply for the
same preview. A reviewed script does not itself grant consent.

`scripts/safe-exec.sh` accepts an executable and separate arguments, previews those
arguments, requires literal `confirm`, logs before executing and preserves argv.
It gates every invocation and performs no automatic plan or command-string eval.
It is not a sandbox: it cannot validate the meaning or downstream effects of an
explicitly invoked shell or program. Callers must still inspect exact targets.

## 2026-09-16 supersession

This replaces the duplicated same-turn protocol and classification of every
externally visible action as destructive. The earlier approximate incident-
prevention percentage had no demonstrated measurement and is withdrawn; the
no-hidden-destruction requirement is retained.
