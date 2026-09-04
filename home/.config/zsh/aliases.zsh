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
alias p='pnpm'
alias pi='pnpm install'
alias pd='pnpm dev'
alias pb='pnpm build'
alias pt='pnpm test'

# Homebrew
alias brewup='brew update && brew upgrade && brew cleanup'
alias brewout='brew outdated'
alias brewls='brew leaves'

# Rust / Cargo
alias cg='cargo'
alias cgb='cargo build'
alias cgr='cargo run'
alias cgf='cargo fmt'
alias cgc='cargo clippy'

# Python
alias py='python3'
alias venv='python3 -m venv .venv && source .venv/bin/activate'
alias activate='source .venv/bin/activate'

# Proyectos
alias dev='cd ~/dev'
proj() {
  cd "$HOME/dev/$1" 2>/dev/null || echo "No existe ~/dev/$1"
}

# Claude status bar
alias cs='claude-statusbar'
alias cstatus='claude-statusbar'
