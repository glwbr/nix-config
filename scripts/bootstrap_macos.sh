#!/usr/bin/env bash
#
# Bootstrap this dotfiles repo on macOS:
#   1. Symlink ~/.zshenv and ~/.config/zsh to the tracked files in this repo
#   2. Install the CLI tools declared in the Brewfile (via `brew bundle`)
#
# Safe to re-run: existing real files are backed up to <file>.bak-<n>, and
# correct symlinks are left untouched.
#
# Usage: scripts/bootstrap_macos.sh

set -euo pipefail

has() {
  command -v "$1" >/dev/null 2>&1 || return 1
}

error() {
  echo -e "\033[31m[$(date +'%Y-%m-%dT%H:%M:%S')]: ${*} \033[0m" >&2
}

log() {
  echo -e "\033[32m${*}\033[0m" >&2
}

warn() {
  echo -e "\033[33mWARNING: ${*}\033[0m"
}

# Repo root = parent of this script's directory
readonly REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

link() {
  local src="$1" dest="$2"

  if [[ ! -e "$src" ]]; then
    error "source does not exist: $src"
    return 1
  fi

  # Already the correct symlink? nothing to do.
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    log "ok: $dest -> $src"
    return 0
  fi

  # Back up an existing real file/dir (or wrong symlink).
  if [[ -e "$dest" || -L "$dest" ]]; then
    local backup="$dest.bak"
    local n=0
    while [[ -e "$backup" || -L "$backup" ]]; do
      n=$((n + 1))
      backup="$dest.bak-$n"
    done
    warn "backing up existing $dest -> $backup"
    mv "$dest" "$backup"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  log "linked: $dest -> $src"
}

main() {
  if [[ "$(uname -s)" != "Darwin" ]]; then
    error "This bootstrap targets macOS. On Linux, symlink the same files by hand or use your existing setup."
    exit 1
  fi

  log "Repo: $REPO_DIR"

  # --- Symlinks ---------------------------------------------------------------
  link "$REPO_DIR/.zshenv"            "$HOME/.zshenv"
  link "$REPO_DIR/.config/zsh"        "$HOME/.config/zsh"
  link "$REPO_DIR/.gitconfig"         "$HOME/.gitconfig"
  link "$REPO_DIR/.gitignore_global"  "$HOME/.gitignore_global"
  link "$REPO_DIR/.config/ghostty"    "$HOME/.config/ghostty"

  # Once ZDOTDIR is set (via ~/.zshenv), zsh reads $ZDOTDIR/.zshrc and
  # $ZDOTDIR/.zprofile instead of the ~/ copies, so retire any real ones.
  local f
  for f in "$HOME/.zshrc" "$HOME/.zprofile"; do
    if [[ -f "$f" && ! -L "$f" ]]; then
      warn "retiring dormant $f -> $f.bak"
      mv "$f" "$f.bak"
    fi
  done

  # --- Homebrew packages ------------------------------------------------------
  if has brew; then
    log "Installing packages from Brewfile..."
    brew bundle --file "$REPO_DIR/Brewfile"
  else
    warn "Homebrew not found. Install it from https://brew.sh then re-run this script."
  fi

  log "Done. Open a new terminal (or run: exec zsh) to load the config."
}

main "$@"
