#!/usr/bin/env bash
set -euo pipefail

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "→ Instalando Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "→ Oh My Zsh ya instalado"
fi
echo "  ✓ Zsh listo (abre una terminal nueva para ver Starship)"
