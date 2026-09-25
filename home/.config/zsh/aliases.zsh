# ─── Aliases de Guido ────────────────────────────────────────

# Dotfiles
alias dotfiles='cd ~/.dotfiles'
alias zreload='source ~/.zshrc'

# Git
alias g='git'
alias gs='git status'
alias gst='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gcm='git commit -m'
alias gcma='git commit -am'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gbd='git branch -d'
alias gl='git log --oneline --graph --decorate -20'
alias gd='git diff'

# GitHub CLI
alias prs='gh pr list'
alias prc='gh pr create'
alias ghclone='gh repo clone'

# Package managers (pnpm es el gestor por defecto)
alias npm='pnpm'

# Homebrew
alias brewup='brew update && brew upgrade && brew cleanup'
alias brewout='brew outdated'
alias brewls='brew leaves'

# Python
alias py='python3'
alias venv='python3 -m venv .venv && source .venv/bin/activate'
alias activate='source .venv/bin/activate'

# Proyectos
alias dev='cd ~/dev'
proj() {
  cd "$HOME/dev/$1" 2>/dev/null || echo "No existe ~/dev/$1"
}

# Puertos
port() {
  if [[ -z "$1" ]]; then
    echo "Uso: port <puerto>"
    return 1
  fi
  local process
  process=$(lsof -i ":$1" -P -n | grep LISTEN)
  if [[ -z "$process" ]]; then
    echo "Nada escuchando en el puerto $1"
    return
  fi
  echo "$process"
}

killport() {
  if [[ -z "$1" ]]; then
    echo "Uso: killport <puerto|rango>   ej: killport 3000 | killport 4321-4340"
    return 1
  fi
  local pids
  pids=$(lsof -ti ":$1")
  if [[ -z "$pids" ]]; then
    echo "Nada escuchando en el puerto $1"
    return
  fi
  local -a pid_list
  pid_list=(${(f)pids})
  echo "Matando ${#pid_list} proceso(s) en $1: ${(j:, :)pid_list}"
  echo "$pids" | xargs kill -9
}

ports() {
  echo "── Procesos de desarrollo ──"
  lsof -i -P -n | grep LISTEN | grep -E 'node|bun|deno|java|ruby' || echo "  (ninguno)"
  echo "── Contenedores Docker ──"
  docker ps --format "{{.Names}}\t{{.Ports}}" 2>/dev/null | while IFS=$'\t' read -r name ports; do
    local mapped=$(echo "$ports" | grep -oE '0\.0\.0\.0:[0-9]+->[0-9]+/tcp' | sed 's/0.0.0.0://' | sed 's|->| -> |')
    [[ -n "$mapped" ]] && echo "$name: $mapped"
  done
}

# Puertos de dev a vigilar (lsof acepta rangos con guion).
# 4321-4340 porque Astro arranca en 4321 y va sumando uno por cada dev server.
DEV_PORTS='3000,3001,4200,4321-4340,5173,8080,8090,8443'

devports() {
  local spec="${1:-$DEV_PORTS}"
  local out
  out=$(lsof -i:"$spec" -P -n | grep LISTEN | awk '{p=$9; sub(/.*:/,"",p); printf "  %-6s %-10s pid %s\n", p, $1, $2}' | sort -u)
  if [[ -z "$out" ]]; then
    echo "  (ninguno en uso en: $spec)"
  else
    echo "── Puertos de dev en uso ──"
    echo "$out"
  fi
}

# Claude status bar
alias cs='claude-statusbar'
alias cstatus='claude-statusbar'
