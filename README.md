# dotfiles — Guido

> De factory reset a coding en cinco minutos.

Setup personal de macOS. Un comando para pasar de una máquina limpia a una configurada.

## Instalación

```bash
git clone https://github.com/guidobuilds/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

El script:

1. Instala Xcode Command Line Tools y Homebrew (si faltan)
2. Instala todos los paquetes y apps del `Brewfile`
3. Enlaza los dotfiles de `home/` a `~/` (con backup automático en `~/.dotfiles-backup/`)
4. Instala Oh My Zsh (si falta)
5. Instala los skills de `guidobuilds/skills` con skills.sh (global, todos los agentes y Claude Code)
6. Aplica macOS defaults (Dock, Finder, trackpad)

## Después de install.sh

Estos pasos requieren interacción humana:

- `gh auth login`
- Generar clave SSH: `ssh-keygen -t ed25519 -C "caffaguido@gmail.com"` y añadirla a GitHub
- Revisar `~/.zshrc.local` para tus secretos por máquina (ej. `CONTEXT7_API_KEY`)
- Abrir una terminal nueva

## Estructura

```
dotfiles/
├── Brewfile                  # Paquetes y apps de Homebrew
├── bootstrap.sh              # Entrada remota (curl | bash)
├── install.sh                # Instalador local
├── scripts/                  # Pasos de instalación individuales
│   ├── 01-brew.sh            # Xcode CLT + Homebrew + Brewfile
│   ├── 02-symlinks.sh        # Enlaza home/ → ~/ con backups
│   ├── 03-zsh.sh             # Oh My Zsh
│   ├── 04-skills.sh          # Instala skills de guidobuilds/skills (skills.sh)
│   └── 05-macos.sh           # macOS defaults
└── home/                     # Dotfiles (espejo de ~/)
    ├── .zshrc                # Oh My Zsh + Starship + nvm
    ├── .zshenv               # Cargo (Rust)
    ├── .zprofile             # PATHs (brew, python, bun, pnpm, grok...)
    ├── .gitconfig
    └── .config/
        ├── git/ignore        # Exclusiones globales de Git
        ├── ghostty/config
        ├── starship.toml     # Prompt
        └── zsh/aliases.zsh   # Aliases y funciones
```

## Secretos y config por máquina

`~/.zshrc.local` se carga al final del `.zshrc` y **nunca se versiona**.
Ahí van cosas como `CONTEXT7_API_KEY` o aliases de trabajo locales.
El instalador migra automáticamente los secretos que detecte en tu `.zshrc` antiguo.

## Skills

La fuente única de verdad de tus skills vive en [`guidobuilds/skills`](https://github.com/guidobuilds/skills).
El script `04-skills.sh` los instala con [skills.sh](https://skills.sh) (`npx skills`), de forma global
(usuario), en todos los agentes y en Claude Code.

Editas los skills en el repo y corres `bash ~/.dotfiles/scripts/04-skills.sh` para instalarlos o actualizarlos.

## Mantener el Brewfile al día

```bash
brew bundle dump --brews --casks --force --file=~/.dotfiles/Brewfile
```

Corre esto antes de hacer commit cada vez que instales algo nuevo.
