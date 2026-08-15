#!/usr/bin/env bash

set -euo pipefail

FILE="$HOME/.config/projects"

dir="${1:-}"

if [[ -z "$dir" ]]; then
  read -rp "Directory: " dir
fi

# Expand ~ if supplied by the user.
if [[ "$dir" == "~/"* ]]; then
  dir="$HOME/${dir:2}"
elif [[ "$dir" == "~" ]]; then
  dir="$HOME"
fi

if [[ ! -d "$dir" ]]; then
  dir=$(zoxide query -- "$dir")
fi

# Make path absolute.
dir="$(realpath -e -- "$dir")"

mkdir -p "$(dirname "$FILE")"
touch "$FILE"

# Don't add duplicates.
if grep -Fxq "$dir" "$FILE"; then
  echo "Already exists: $dir"
  exit 0
fi

no_confirm=false
for arg in "$@"; do
  [[ "$arg" == "--no-confirm" ]] && no_confirm=true
done

if [[ "$no_confirm" == false ]]; then
  read -rp "Wanna add: $dir? [y/N] " answer
  if [[ ! "$answer" == [yY] ]]; then
    echo "Canceling"
    exit 0
  fi
fi

printf '%s\n' "$dir" >>"$FILE"
echo "Added : $dir"
