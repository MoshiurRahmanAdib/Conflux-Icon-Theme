#!/usr/bin/env bash
set -euo pipefail

trap 'printf "\nPress any key to continue..."; read -r -n 1 -s || true; printf "\n"' EXIT

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
TARGET_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$TARGET_DIR"

if [ ! -x "$SCRIPT_DIR/.tools/node_modules/.bin/svgo" ]; then
  if ! command -v npm >/dev/null 2>&1; then
    printf 'npm is required to install SVGO. Install Node.js/npm, then run this script again.\n' >&2
    exit 1
  fi

  npm install --prefix "$SCRIPT_DIR/.tools" --no-save svgo
fi

"$SCRIPT_DIR/.tools/node_modules/.bin/svgo" -i .
