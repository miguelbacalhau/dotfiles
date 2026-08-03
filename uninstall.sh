#!/usr/bin/env bash
#
# macOS dotfiles uninstaller.
# Removes only the symlinks that point back into this repo. Real files,
# unrelated symlinks, and any <target>.backup.<ts> files are left alone.
# Homebrew packages are NOT removed (see the note at the end).
#
# NOTE: keep the LINKS map below in sync with install.sh.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# repo-relative source :: absolute symlink target
LINKS=(
  "neovim::$HOME/.config/nvim"
  "ghostty::$HOME/.config/ghostty"
  "tmux::$HOME/.config/tmux"
  "tmux-sessionizer::$HOME/.config/tmux-sessionizer"
  "zsh::$HOME/.config/zsh"
  "zsh/.zshenv::$HOME/.zshenv"
)

log()  { printf '\033[0;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[0;33mwarn:\033[0m %s\n' "$*"; }

unlink_one() {
  local src="$DOTFILES/$1" dest="$2"
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    rm "$dest"
    log "removed  $dest"
  elif [[ -e "$dest" || -L "$dest" ]]; then
    warn "skipped  $dest (not a symlink to this repo)"
  else
    log "absent   $dest"
  fi
}

main() {
  log "Removing dotfiles symlinks..."
  local pair
  for pair in "${LINKS[@]}"; do
    unlink_one "${pair%%::*}" "${pair##*::}"
  done
  log "Done. Homebrew packages were left installed."
  log "To remove them too: brew bundle cleanup --file=\"$DOTFILES/Brewfile\" --force"
  log "Any *.backup.* files from install were left untouched."
}

main "$@"
