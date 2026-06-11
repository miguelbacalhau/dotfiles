# =========================================================
# tmux auto-start
# =========================================================
# For interactive shells not already inside tmux, attach to an
# existing session if one exists, otherwise start a new one.
#   -A          attach if the session exists, else create it
#   -s main     the session name to attach to / create
#   exec        replace zsh with tmux so quitting tmux closes the shell

if command -v tmux &>/dev/null && [[ -n "$PS1" && -z "$TMUX" ]]; then
  exec tmux new-session -A -s main
fi
