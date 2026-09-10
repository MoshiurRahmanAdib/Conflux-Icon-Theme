#!/usr/bin/env python3
"""Create 58 px JetBrains icon copies on a 64 px SVG canvas.

The original SVGs stay in the parent directory. This script writes adjusted
copies into the directory containing this file.
"""

from pathlib import Path
import re

SOURCE_DIR = Path(__file__).resolve().parent.parent
OUTPUT_DIR = Path(__file__).resolve().parent

# A 64-unit drawing rendered through this viewBox becomes exactly 58 units in
# a 64-unit viewport, with the result centered.
RESIZED_VIEWBOX = "-3.3103448276 -3.3103448276 70.6206896552 70.6206896552"
VIEWBOX_PATTERN = re.compile(r'viewBox="0 0 64 64"')


def main() -> None:
    sources = sorted(SOURCE_DIR.glob("*.svg"))
    if not sources:
        raise SystemExit("No SVG files found in the parent directory.")

    for source in sources:
        content = source.read_text(encoding="utf-8")
        resized, replacements = VIEWBOX_PATTERN.subn(
            f'viewBox="{RESIZED_VIEWBOX}"', content, count=1
        )
        if replacements != 1:
            raise SystemExit(f"Expected one 64×64 viewBox in {source.name}.")
        (OUTPUT_DIR / source.name).write_text(resized, encoding="utf-8")
        print(f"Wrote {source.name}")


if __name__ == "__main__":
    main()
