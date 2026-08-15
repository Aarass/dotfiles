#! /usr/bin/env bash

# git diff -- . ':(exclude)*word1*' ':(exclude)*word2*'

options_file="$HOME/.config/projects"
if [[ ! -f "$options_file" ]]; then
  read -rp "Projects file doesn't exist..."
  exit
fi

dir=$(fzf --layout=reverse <"$options_file")
cd "$dir" || exit

words=()

get_pattern() {
  pattern=""
  for word in "${words[@]}"; do
    pattern+="':(exclude)*$word*' "
  done
  printf '%s\n' "$pattern"
}

get_word() {
  pattern=$(get_pattern)

  eval "git diff --name-only -- . $pattern" |
    fzf \
      --header="$pattern" \
      --header-first \
      --disabled \
      --layout=reverse \
      --info=hidden \
      --print-query \
      --no-color \
      --color='bg+:-1,fg+:-1' | head -n 1
}

while true; do
  word=$(get_word | xargs)
  [[ -z "$word" ]] && break
  words+=("$word")
done

pattern=$(get_pattern)
cmd="git diff -- . $pattern"
echo -n "$cmd" | wl-copy

cd - >/dev/null 2>&1 || exit
