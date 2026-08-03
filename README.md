# Dotfiles

Personal configuration for my terminal-centric setup: Neovim, Ghostty, tmux,
and a modular Zsh. macOS is the supported platform for the install scripts;
the Linux/Wayland configs live here too but are managed manually for now.

## Requirements

Everything below is installed for you by [`install.sh`](./install.sh) via
Homebrew (see the [`Brewfile`](./Brewfile)):

| Tool                          | Purpose                                    |
| ----------------------------- | ------------------------------------------ |
| `neovim`                      | Editor (LazyVim-based config)              |
| `tmux`                        | Terminal multiplexer                       |
| `starship`                    | Shell prompt                               |
| `fzf`                         | Fuzzy finder                               |
| `fd`                          | Fast file search (fzf backend)             |
| `ripgrep`                     | Fast content search                        |
| `git`                         | Version control                            |
| `ghostty` (cask)              | Terminal emulator                          |
| `font-monaspace-nerd-font`    | Terminal font (MonaspiceNe Nerd Font)      |

## Install (macOS)

```sh
git clone <this-repo> ~/development/dotfiles
cd ~/development/dotfiles
./install.sh
```

`install.sh` will:

1. Install Homebrew if it isn't already present.
2. Install every package in the `Brewfile`.
3. Symlink the configs listed below into place.

The installer is **idempotent** and **non-destructive**: links that already
point here are left as-is, and any existing real file or directory is moved to
`<target>.backup.<timestamp>` before its symlink is created.

Start a new shell (or `exec zsh`) afterwards to pick up the changes.

## What gets linked

| Repo path           | Symlink target                |
| ------------------- | ----------------------------- |
| `neovim/`           | `~/.config/nvim`              |
| `ghostty/`          | `~/.config/ghostty`           |
| `tmux/`             | `~/.config/tmux`              |
| `tmux-sessionizer/` | `~/.config/tmux-sessionizer`  |
| `zsh/`              | `~/.config/zsh`               |
| `zsh/.zshenv`       | `~/.zshenv`                   |

`~/.zshenv` is the only file placed in `$HOME`; it sets `ZDOTDIR` so the rest
of the Zsh config is sourced from `~/.config/zsh`.

## Uninstall

```sh
./uninstall.sh
```

Removes only the symlinks that point back into this repo — real files,
unrelated symlinks, and any `*.backup.*` files are left untouched. Homebrew
packages stay installed; the script prints the `brew bundle cleanup` command if
you want to remove them too.

## Layout

```
neovim/            Neovim config (LazyVim: init.lua + lua/{config,plugins})
ghostty/           Ghostty terminal config
tmux/              tmux config
tmux-sessionizer/  tmux-sessionizer config
zsh/               Modular Zsh config (.zshenv, .zshrc, aliases, prompt, …)
Brewfile           Homebrew packages
install.sh         macOS installer
uninstall.sh       macOS uninstaller
```

### Linux / Wayland (manual)

`hypr/`, `sway/`, `waybar/`, `dunst/`, `greetd/`, `plank/`, `rofi/`,
`scripts/`, and `wallpapers/` are part of my Linux desktop and are **not**
touched by the macOS install scripts.
