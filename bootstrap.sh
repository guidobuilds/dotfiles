#!/usr/bin/env bash
# Instalación remota desde una máquina limpia:
#   curl -fsSL https://raw.githubusercontent.com/guidobuilds/dotfiles/main/bootstrap.sh | bash
set -euo pipefail

REPO="https://github.com/guidobuilds/dotfiles.git"

if [ ! -d "$HOME/.dotfiles" ]; then
  git clone "$REPO" "$HOME/.dotfiles"
else
  echo "~/.dotfiles ya existe, actualizando..."
  git -C "$HOME/.dotfiles" pull
fi

cd "$HOME/.dotfiles"
./install.sh
