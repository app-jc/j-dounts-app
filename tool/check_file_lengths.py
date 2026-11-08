#!/usr/bin/env python3
"""Enforce the repository's approximate 300-line Dart source limit."""

import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
SOURCE_DIRECTORIES = (Path("lib"), Path("test"))
MAX_LINES = 300
GENERATED_SUFFIXES = (".g.dart", ".freezed.dart")
GENERATED_LOCALIZATION_PREFIX = "app_localizations"


def is_generated(path: Path) -> bool:
    return path.name.endswith(GENERATED_SUFFIXES) or (
        path.name.startswith(GENERATED_LOCALIZATION_PREFIX)
        and path.suffix == ".dart"
    )


def main() -> int:
    violations: list[str] = []
    for directory in SOURCE_DIRECTORIES:
        for path in sorted((PROJECT_ROOT / directory).rglob("*.dart")):
            if is_generated(path):
                continue

            line_count = len(path.read_text(encoding="utf-8").splitlines())
            if line_count > MAX_LINES:
                relative_path = path.relative_to(PROJECT_ROOT)
                violations.append(
                    f"{relative_path}: {line_count} lines "
                    f"(limit: {MAX_LINES})"
                )

    if violations:
        print("\n".join(violations), file=sys.stderr)
        return 1

    print(f"Dart file-length check passed (limit: {MAX_LINES} lines).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
