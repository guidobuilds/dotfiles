#!/usr/bin/env bash
set -euo pipefail

# Fuente única de verdad de skills: guidobuilds/skills
# Instala de forma interactiva: pregunta por cada skill antes de instalarla.
# Se instalan globalmente (usuario) en todos los agentes + Claude Code.

REPO="guidobuilds/skills"
REPO_URL="https://github.com/$REPO.git"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# Asegura que Homebrew (node/npx) esté en PATH en una máquina limpia
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "→ Cargando skills desde $REPO..."
if ! git clone --depth 1 -q "$REPO_URL" "$TMP/skills"; then
  echo "  ⚠️  No se pudo clonar $REPO_URL"
  exit 1
fi

# Extrae los nombres de skills desde el frontmatter de cada SKILL.md
SKILLS=()
while IFS= read -r s; do
  SKILLS+=("$s")
done < <(
  find "$TMP/skills" -name SKILL.md -maxdepth 3 \
    -exec awk '/^name:[[:space:]]*[^[:space:]]/{print $2; exit}' {} \; \
    | sort -u
)

if [ "${#SKILLS[@]}" -eq 0 ]; then
  echo "  ⚠️  No se encontraron skills en $REPO"
  exit 0
fi

echo "  Se encontraron ${#SKILLS[@]} skills:"
for s in "${SKILLS[@]}"; do
  echo "    • $s"
done
echo ""

# Confirmación interactiva skill por skill
INSTALLED=()
for s in "${SKILLS[@]}"; do
  printf "  ¿Instalar skill '%s'? [y/N] " "$s"
  read -r ans
  case "${ans:-}" in
    y|Y|yes|YES|s|S|si|SI) INSTALLED+=("$s") ;;
    *) echo "    ✗ omitido: $s" ;;
  esac
done

if [ "${#INSTALLED[@]}" -eq 0 ]; then
  echo "  ✓ No se instaló ningún skill."
  exit 0
fi

echo ""
echo "→ Instalando ${#INSTALLED[@]} skills (global, todos los agentes + Claude Code)..."
for s in "${INSTALLED[@]}"; do
  echo "  ── $s ──"
  npx --yes skills@latest add "$REPO" \
    --skill "$s" \
    --global \
    --agent '*' \
    --agent claude-code \
    --yes
done

echo "  ✓ Skills instalados"
