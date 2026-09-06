# ─── Homebrew ────────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"

# ─── Python 3.13 (framework) ─────────────────────────────────
PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"
export PATH

# ─── Codex CLI / binarios locales ────────────────────────────
export PATH="$HOME/.local/bin:$PATH"

# ─── Node.js (brew node@22) ──────────────────────────────────
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

# ─── Bun ─────────────────────────────────────────────────────
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ─── pnpm ────────────────────────────────────────────────────
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# ─── Antigravity ─────────────────────────────────────────────
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"


