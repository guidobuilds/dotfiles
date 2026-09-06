# ─── Oh My Zsh ───────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# Starship se encarga del prompt, así que OMZ no usa tema
ZSH_THEME=""

# Plugins de OMZ (los de autosuggestions/highlighting van via brew abajo)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# ─── zsh-autosuggestions + zsh-syntax-highlighting (Homebrew) ─
[[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# ─── Node Version Manager ────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # carga nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ─── Editor ──────────────────────────────────────────────────
export EDITOR='nvim'

# ─── Aliases propios ─────────────────────────────────────────
[ -f ~/.config/zsh/aliases.zsh ] && source ~/.config/zsh/aliases.zsh

# ─── Config local por máquina (secretos, trabajo) — NO en git ─
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# ─── Starship prompt (último para que tome el control) ───────
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
