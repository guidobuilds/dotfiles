#!/usr/bin/env bash
set -euo pipefail

# macOS defaults — ajusta o comenta lo que no quieras
echo "→ Aplicando macOS defaults..."

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Trackpad: tap para hacer clic
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Paneles de guardar/abrir expandidos
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

killall Dock Finder 2>/dev/null || true
echo "  ✓ macOS defaults aplicados"
