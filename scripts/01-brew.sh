#!/usr/bin/env bash
set -euo pipefail

echo "→ Xcode Command Line Tools..."
if ! xcode-select -p >/dev/null 2>&1; then
  echo "  ⚠️  Necesitas instalar Xcode CLT: xcode-select --install"
  echo "  Después de instalarlos, vuelve a ejecutar install.sh"
  exit 1
fi
echo "  ✓ CLT presentes"

echo "→ Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "  ✓ Homebrew ya instalado"
fi

echo "→ Instalando paquetes y apps del Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile"
echo "  ✓ Brewfile aplicado"
