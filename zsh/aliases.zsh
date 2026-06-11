# =========================================================
# Aliases
# =========================================================

# Colorize ls (oh-my-zsh does this via theme-and-appearance.zsh).
# `la` inherits the color flag because zsh re-expands the aliased `ls`.
if ls --color -d . &>/dev/null; then
  alias ls='ls --color=tty'   # GNU coreutils (Linux)
elif ls -G -d . &>/dev/null; then
  alias ls='ls -G'            # BSD ls (macOS)
fi

# oh-my-zsh's `la`: long listing, all files (incl. dotfiles, excl. . and ..),
# human-readable sizes
alias la='ls -lAh'
