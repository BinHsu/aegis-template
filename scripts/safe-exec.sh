#!/usr/bin/env bash
# Explicit argv confirmation wrapper; not a destructive-command detector or sandbox.
# Usage: scripts/safe-exec.sh executable [argument ...]
set -euo pipefail

if [ "$#" -eq 0 ]; then
  echo "usage: safe-exec.sh executable [argument ...]" >&2
  exit 2
fi
command -v python3 >/dev/null || { echo "python3 required for audit logging" >&2; exit 2; }

printf 'Command (shell-escaped argv):'
printf ' %q' "$@"
printf '\nReview exact targets and recoverability before confirming.\n'
if ! read -r -p "Type 'confirm' to proceed: " answer || [ "$answer" != "confirm" ]; then
  echo "Aborted."
  exit 1
fi

# Any logging error must abort before the command. JSON preserves argument boundaries
# and escapes quotes/newlines; the receipt is flushed before execution begins.
python3 - "$@" <<'LOGPY'
import datetime
import json
import os
import sys
from pathlib import Path

log_dir = Path(".agent-context")
log_dir.mkdir(mode=0o700, exist_ok=True)
receipt = {
    "ts": datetime.datetime.now(datetime.timezone.utc).isoformat(),
    "argv": sys.argv[1:],
    "user": os.environ.get("USER", "unknown"),
    "cwd": os.getcwd(),
}
fd = os.open(log_dir / "destructive-log.jsonl", os.O_WRONLY | os.O_CREAT | os.O_APPEND, 0o600)
with os.fdopen(fd, "a") as stream:
    stream.write(json.dumps(receipt) + "\n")
    stream.flush()
    os.fsync(stream.fileno())
LOGPY

"$@"
