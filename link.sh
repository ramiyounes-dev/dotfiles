#!/bin/bash
# Symlink dotfiles to home directory (run standalone or called from setup.sh)

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

echo "Linking dotfiles from $DOTFILES_DIR..."

_link() {
    local src="$DOTFILES_DIR/$1" dst="$HOME/$1"
    if [ ! -e "$src" ]; then
        echo "  skip $1 (not found)"
        return
    fi
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        local backup="${dst}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "  backed up $dst -> $backup"
        mv "$dst" "$backup"
    fi
    ln -sf "$src" "$dst"
    echo "  linked $1"
}

_link .zshrc
_link .gitconfig

# Starship config lives in ~/.config/
mkdir -p "$HOME/.config"
if [ -f "$DOTFILES_DIR/starship.toml" ]; then
    ln -sf "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
    echo "  linked starship.toml -> ~/.config/starship.toml"
fi

echo ""
echo "Done. Run: source ~/.zshrc"
