# =========================================================
# tmux auto-start
# =========================================================
# For interactive shells not already inside tmux, start a fresh
# session every time a new terminal opens.
#   new-session   always create a new (unnamed) session
#   exec          replace zsh with tmux so quitting tmux closes the shell

if command -v tmux &>/dev/null && [[ -n "$PS1" && -z "$TMUX" ]]; then
  exec tmux new-session
fi
