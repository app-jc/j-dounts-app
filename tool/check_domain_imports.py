#!/usr/bin/env python3
"""Reject Flutter, Drift, and Serverpod imports from Dart domain folders."""

import re
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
DOMAIN_DIRECTORY = "domain"
GENERATED_SUFFIXES = (".g.dart", ".freezed.dart")
DIRECTIVE_PATTERN = re.compile(
    r"^\s*(?:import|export|part)\s+(.+?);",
    re.MULTILINE | re.DOTALL,
)
URI_PATTERN = re.compile(r"""['"]([^'"]+)['"]""")
FORBIDDEN_URI_PATTERN = re.compile(
    r"^(?:dart:ui|package:(?:flutter(?:/|$)|drift(?:_|/|$)|serverpod(?:_|/|$)))"
)


def main() -> int:
    violations: list[str] = []
    for path in sorted((PROJECT_ROOT / "lib").rglob("*.dart")):
        if DOMAIN_DIRECTORY not in path.relative_to(PROJECT_ROOT).parts:
            continue
        if path.name.endswith(GENERATED_SUFFIXES):
            continue

        source = path.read_text(encoding="utf-8")
        for directive in DIRECTIVE_PATTERN.finditer(source):
            for uri in URI_PATTERN.finditer(directive.group(1)):
                if FORBIDDEN_URI_PATTERN.match(uri.group(1)):
                    line = source.count("\n", 0, directive.start()) + 1
                    relative_path = path.relative_to(PROJECT_ROOT)
                    violations.append(
                        f"{relative_path}:{line}: prohibited import "
                        f"{uri.group(1)!r}"
                    )

    if violations:
        print("\n".join(violations), file=sys.stderr)
        return 1

    print("Domain import check passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
