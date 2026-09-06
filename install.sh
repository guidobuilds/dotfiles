#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_DIR

echo "🚀 Instalando dotfiles de Guido..."
echo ""

for script in "$DOTFILES_DIR"/scripts/*.sh; do
  echo "── $(basename "$script") ──"
  bash "$script"
  echo ""
done

echo "✅ Dotfiles instalados."
echo ""
echo "Pasos manuales pendientes:"
echo "  1. gh auth login"
echo "  2. ssh-keygen -t ed25519 -C 'TU_EMAIL@users.noreply.github.com' y añadir la clave a GitHub"
echo "  3. Revisa ~/.zshrc.local (secretos como CONTEXT7_API_KEY)"
echo "  4. Abre una terminal nueva 🎉"
