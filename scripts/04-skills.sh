#!/usr/bin/env bash
set -euo pipefail

# Fuente única de verdad de skills: guidobuilds/skills
# Se instalan globalmente (usuario) en todos los agentes + Claude Code
# usando el CLI de skills.sh (npx skills).

echo "→ Instalando skills desde guidobuilds/skills con skills.sh..."
echo "  (global, todos los agentes + Claude Code)"

npx --yes skills@latest add guidobuilds/skills \
  --skill '*' \
  --global \
  --agent '*' \
  --agent claude-code \
  --yes

echo "  ✓ Skills instalados"
