#!/usr/bin/env bash
set -euo pipefail

CODEGRAPH_BIN="$HOME/.local/bin/codegraph"

echo "→ CodeGraph..."
if [ ! -x "$CODEGRAPH_BIN" ]; then
  INSTALLER="$(mktemp)"
  trap 'rm -f "$INSTALLER"' EXIT

  curl -fsSL \
    https://raw.githubusercontent.com/colbymchenry/codegraph/main/install.sh \
    -o "$INSTALLER"
  sh "$INSTALLER"
else
  echo "  ✓ CodeGraph ya instalado"
fi

echo "→ Configurando CodeGraph en los agentes detectados..."
"$CODEGRAPH_BIN" install --target=auto --location=global --yes
echo "  ✓ CodeGraph configurado"
