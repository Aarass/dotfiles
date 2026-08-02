SESSION="serve"
ROOT="$HOME/.config"

tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESSION -c "$ROOT"
  tmux send-keys -t $SESSION "npx nx run serve" C-m
  tmux split-window -t $SESSION -c "$ROOT"
  tmux send-keys -t $SESSION "npx nx run mos:serve" C-m
fi

tmux attach-session -t $SESSION
