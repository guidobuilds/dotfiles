#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link_file() {
  local src="$1" dst="$2"
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    if [ "$(readlink "$dst" 2>/dev/null || echo '')" = "$src" ]; then
      echo "  ✓ ya enlazado: $dst"
      return
    fi
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    echo "  → backup: $dst → $BACKUP_DIR/"
  fi
  ln -s "$src" "$dst"
  echo "  ✓ enlazado: $dst → $src"
}

mkdir -p "$HOME/.config/git" "$HOME/.config/ghostty" "$HOME/.config/zsh"

link_file "$DOTFILES/home/.zshrc"                  "$HOME/.zshrc"
link_file "$DOTFILES/home/.zprofile"               "$HOME/.zprofile"
link_file "$DOTFILES/home/.gitconfig"              "$HOME/.gitconfig"
link_file "$DOTFILES/home/.config/git/ignore"      "$HOME/.config/git/ignore"
link_file "$DOTFILES/home/.config/ghostty/config"  "$HOME/.config/ghostty/config"
link_file "$DOTFILES/home/.config/starship.toml"   "$HOME/.config/starship.toml"
link_file "$DOTFILES/home/.config/zsh/aliases.zsh" "$HOME/.config/zsh/aliases.zsh"

# Config local por máquina (secretos como CONTEXT7_API_KEY) — nunca en git
touch "$HOME/.zshrc.local"

# Migra secretos del .zshrc respaldado al local si no están ya
if [ -f "$BACKUP_DIR/.zshrc" ] && ! grep -q 'CONTEXT7_API_KEY' "$HOME/.zshrc.local" 2>/dev/null; then
  grep 'CONTEXT7_API_KEY' "$BACKUP_DIR/.zshrc" >> "$HOME/.zshrc.local" 2>/dev/null || true
  echo "  → CONTEXT7_API_KEY migrado a ~/.zshrc.local"
fi
