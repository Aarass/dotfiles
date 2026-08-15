#!/usr/bin/env bash

declare -A tools=(
  [git diff filtered]="$HOME/.config/scripts/toolbox/filtered_git_diff.sh"
  [add/save project]="$HOME/.config/scripts/toolbox/add-project.sh"
)

while true; do
  choice=$(printf '%s\n' "${!tools[@]}" | fzf --layout=reverse)
  path="${tools[$choice]}"

  "$path"

  read -rp "Press Enter to close..."
  pypr-client toggle toolbox
done
