# ---------- XDG base directories ----------
# Centralizes config/cache/data locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ---------- Zsh config location ----------
# The zsh config lives in $XDG_CONFIG_HOME/zsh; ~/.zshenv (this file) is the
# only piece in $HOME and points zsh at the rest.
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# ---------- Homebrew ----------
# Put brew (and brew-installed tools: nvim, tmux, starship, fzf, fd, rg) on PATH.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"   # Apple Silicon
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"      # Intel
fi

# ---------- Local binaries ----------
# Tools built from source (trk) install here.
export PATH="$HOME/.local/bin:$PATH"

# ---------- Starship ----------
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"
