#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/.dotfiles"
AI_SRC="$HOME/dev/ai"

# 1) Fuente única de verdad: guidobuilds/ai
if [ ! -d "$AI_SRC/.git" ]; then
  echo "→ Clonando guidobuilds/ai en ~/dev/ai..."
  mkdir -p "$HOME/dev"
  git clone git@github.com:guidobuilds/ai.git "$AI_SRC" 2>/dev/null || \
    git clone https://github.com/guidobuilds/ai.git "$AI_SRC"
else
  echo "→ guidobuilds/ai ya está en ~/dev/ai"
fi

# Enlace dentro del repo de dotfiles
if [ ! -L "$DOTFILES/ai" ]; then
  ln -s "$AI_SRC" "$DOTFILES/ai"
  echo "  ✓ ~/.dotfiles/ai → $AI_SRC"
fi

# 2) Sincroniza skills/agents del repo ai/ a cada agente
sync_dir() {
  local src="$1" dst="$2"
  [ -d "$src" ] || return 0
  mkdir -p "$dst"
  for item in "$src"/*; do
    local name
    name="$(basename "$item")"
    if [ ! -e "$dst/$name" ] && [ ! -L "$dst/$name" ]; then
      ln -s "$item" "$dst/$name"
      echo "  → $name → $dst/"
    fi
  done
}

echo "→ Sincronizando skills y agents..."
sync_dir "$AI_SRC/skills" "$HOME/.claude/skills"
sync_dir "$AI_SRC/skills" "$HOME/.opencode/skills"
sync_dir "$AI_SRC/skills" "$HOME/.agents/skills"
sync_dir "$AI_SRC/agents" "$HOME/.claude/agents"
sync_dir "$AI_SRC/agents" "$HOME/.codex/agents"
sync_dir "$AI_SRC/agents" "$HOME/.gemini/agents"
echo "  ✓ IA sincronizada"
