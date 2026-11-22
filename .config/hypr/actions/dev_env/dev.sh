SESSION="dev"
ROOT="$HOME/oms"

tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESSION -n frontend -c "$ROOT/KBS_Suite/KBS.Web"
  tmux send-keys -t $SESSION:frontend "nvim ." C-m
  tmux new-window -t $SESSION -n backend -c "$ROOT/KBS_Suite/KBS.ExecutionManager"
  tmux send-keys -t $SESSION:backend "nvim ." C-m
  tmux new-window -t $SESSION -c "$ROOT"
fi

tmux attach-session -t $SESSION
