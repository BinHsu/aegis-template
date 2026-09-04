#!/usr/bin/env python3
"""Print the global policy entry point and every file it imports with @path."""

from __future__ import annotations

import argparse
from pathlib import Path
import re
import sys


IMPORT = re.compile(r"^\s*@([^\s]+)\s*$")


def load(path: Path, seen: set[Path]) -> list[tuple[Path, str]]:
    resolved = path.expanduser().resolve()
    if resolved in seen:
        return []
    seen.add(resolved)
    try:
        text = resolved.read_text()
    except OSError as exc:
        raise RuntimeError(f"cannot read global policy: {resolved}: {exc}") from exc
    documents = [(resolved, text)]
    for line in text.splitlines():
        match = IMPORT.match(line)
        if match:
            imported = Path(match.group(1)).expanduser()
            if not imported.is_absolute():
                imported = resolved.parent / imported
            documents.extend(load(imported, seen))
    return documents


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("entry", nargs="?", default="~/.claude/CLAUDE.md")
    args = parser.parse_args()
    try:
        documents = load(Path(args.entry), set())
    except RuntimeError as exc:
        print(exc, file=sys.stderr)
        return 1
    for path, text in documents:
        print(f"=== {path} ===")
        print(text, end="" if text.endswith("\n") else "\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
