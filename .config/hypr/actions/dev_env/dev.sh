SESSION="dev"
ROOT="$HOME/.config"

tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESSION -n editor -c "$ROOT"
  tmux send-keys -t $SESSION:editor "nvim ." C-m
  tmux new-window -t $SESSION -c "$ROOT"
fi

tmux attach-session -t $SESSION:editor
