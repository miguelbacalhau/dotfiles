#!/usr/bin/env bash
#
# macOS dotfiles installer.
#   1. Installs Homebrew (if missing) and the packages in ./Brewfile
#   2. Symlinks the macOS-relevant configs into place
#
# Idempotent: existing non-symlink targets are backed up to <target>.backup.<ts>,
# and links that already point here are left untouched.
#
# NOTE: keep the LINKS map below in sync with uninstall.sh.

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
die()  { printf '\033[0;31merror:\033[0m %s\n' "$*" >&2; exit 1; }

[[ "$(uname -s)" == "Darwin" ]] || die "This installer targets macOS only."

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    log "Homebrew already installed."
  else
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  # ensure brew is on PATH for the rest of this script
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

install_packages() {
  log "Installing packages from Brewfile..."
  brew bundle --file="$DOTFILES/Brewfile"
}

backup() {
  local target="$1"
  local bak="${target}.backup.$(date +%Y%m%d%H%M%S)"
  warn "backing up $target -> $bak"
  mv "$target" "$bak"
}

link_one() {
  local src="$DOTFILES/$1" dest="$2"
  [[ -e "$src" ]] || { warn "missing source $src, skipping"; return; }
  mkdir -p "$(dirname "$dest")"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    log "ok    $dest"
    return
  fi
  if [[ -e "$dest" || -L "$dest" ]]; then
    backup "$dest"
  fi
  ln -sfn "$src" "$dest"
  log "link  $dest -> $src"
}

symlink_all() {
  log "Symlinking dotfiles..."
  local pair
  for pair in "${LINKS[@]}"; do
    link_one "${pair%%::*}" "${pair##*::}"
  done
}

main() {
  install_homebrew
  install_packages
  symlink_all
  log "Done. Start a new shell (or run: exec zsh) to pick up the changes."
}

main "$@"
