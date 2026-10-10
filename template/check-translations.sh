#!/usr/bin/env bash
# Checks that every language folder has the same chapter files as the master.
# Run from the project root:  bash check-translations.sh [master]
# `master` defaults to `en`.
set -euo pipefail
cd "$(dirname "$0")"

master="${1:-en}"
if [ ! -d "$master/content" ]; then
  echo "error: no master content folder at $master/content" >&2
  exit 1
fi

status=0
for dir in */; do
  [ -f "${dir}main.typ" ] || continue
  [ "$dir" = "$master/" ] && continue
  echo "== $dir vs $master/"
  if [ ! -d "${dir}content" ]; then
    echo "-> ${dir}content is missing" >&2
    status=1
    continue
  fi
  if ! diff <(cd "$master/content" && ls | sort) <(cd "$dir/content" && ls | sort); then
    echo "-> ${dir}content does not match the master's content/" >&2
    status=1
  fi
done

if [ "$status" -ne 0 ]; then
  echo "Chapter files differ from the master." >&2
  exit 1
fi
echo "All language folders match $master/."
