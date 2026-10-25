#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

notify() {
  if command -v notify-send >/dev/null 2>&1; then
    if ! notify-send --app-name="Conflux Icon Theme Update" --icon=system-software-update "$1" "$2"; then
      printf 'Failed to display desktop notification: %s\n' "$2" >&2
    fi
  else
    printf 'Notification unavailable (notify-send is not installed): %s\n' "$2" >&2
  fi
}

previous_commit="$(git -C "$SCRIPT_DIR" rev-parse HEAD)"

if pull_output="$(git -C "$SCRIPT_DIR" pull 2>&1)"; then
  printf '%s\n' "$pull_output"
  current_commit="$(git -C "$SCRIPT_DIR" rev-parse HEAD)"

  if [[ "$previous_commit" == "$current_commit" ]]; then
    notify "Already up to date" "$pull_output"
  else
    notify "Update completed" "$pull_output"
  fi
else
  pull_status=$?
  printf '%s\n' "$pull_output" >&2
  notify "Update failed" "$pull_output"
  exit "$pull_status"
fi
