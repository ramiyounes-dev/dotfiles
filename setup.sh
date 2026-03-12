#!/bin/bash
# Rami Younes - macOS Dev Environment Setup
# Idempotent bootstrap for MacBook M4 (Apple Silicon) development machines

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

echo "Starting dev environment setup..."
echo ""

# ── Guards ──────────────────────────────────────────────────────────────────

if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: macOS only." && exit 1
fi

if [[ "$(uname -m)" != "arm64" ]]; then
    echo "Warning: Optimized for Apple Silicon. Proceed? (y/n)"
    read -r -n 1 reply; echo
    [[ "$reply" =~ ^[Yy]$ ]] || exit 1
fi

# ── Rosetta 2 ────────────────────────────────────────────────────────────────

echo "Checking Rosetta 2..."
if ! /usr/bin/pgrep oahd >/dev/null 2>&1; then
    softwareupdate --install-rosetta --agree-to-license
else
    echo "  already installed"
fi

# ── Homebrew ─────────────────────────────────────────────────────────────────

echo ""
echo "Homebrew..."
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "  already installed"
    brew update --quiet
fi

# ── CLI Tools ─────────────────────────────────────────────────────────────────

echo ""
echo "Installing CLI tools..."
brew install \
    mise \
    starship \
    uv \
    jq \
    gh \
    fzf \
    btop \
    tldr \
    ripgrep \
    fd \
    bat \
    eza \
    zoxide \
    git-delta \
    lazygit \
    just \
    httpie \
    direnv \
    pgcli \
    redis \
    gnu-cobol \
    docker \
    docker-compose \
    zsh-autosuggestions \
    zsh-syntax-highlighting

# ── GUI Apps ──────────────────────────────────────────────────────────────────

echo ""
echo "Installing apps..."
brew install --cask orbstack
brew install --cask ghostty
brew install --cask visual-studio-code

# ── Dotfile Symlinks ──────────────────────────────────────────────────────────

echo ""
echo "Linking dotfiles..."

_link() {
    local src="$DOTFILES_DIR/$1" dst="$HOME/$1"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mv "$dst" "${dst}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "  backed up $dst"
    fi
    ln -sf "$src" "$dst"
    echo "  linked $1"
}

_link .zshrc
_link .gitconfig

# Starship config
mkdir -p "$HOME/.config"
if [ -f "$DOTFILES_DIR/starship.toml" ]; then
    ln -sf "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
    echo "  linked starship.toml"
fi

# ── Languages ─────────────────────────────────────────────────────────────────

echo ""
echo "Installing languages via mise..."
mise use -g python@3.13
mise use -g node@lts
mise use -g java@21

# ── Python Tools ──────────────────────────────────────────────────────────────

echo ""
echo "Installing Python tools..."
uv tool install ruff
uv tool install mypy
uv tool install pre-commit

# ── SSH Key ───────────────────────────────────────────────────────────────────

echo ""
echo "SSH key..."
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    read -r -p "Email for SSH key: " email
    ssh-keygen -t ed25519 -C "$email" -f "$HOME/.ssh/id_ed25519"
    eval "$(ssh-agent -s)"
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
    cat ~/.ssh/id_ed25519.pub | pbcopy
    echo ""
    echo "Public key copied to clipboard. Add it at: https://github.com/settings/ssh/new"
    echo ""
    cat ~/.ssh/id_ed25519.pub
else
    echo "  already exists"
fi

# ── VSCode Extensions ─────────────────────────────────────────────────────────

echo ""
echo "Installing VSCode extensions..."
code --install-extension usernamehw.errorlens
code --install-extension eamodio.gitlens
code --install-extension astral-sh.ruff
code --install-extension redhat.vscode-yaml
code --install-extension bitlang.cobol
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension github.copilot
code --install-extension github.copilot-chat
code --install-extension esbenp.prettier-vscode

# ── GitHub CLI Extensions ─────────────────────────────────────────────────────

echo ""
echo "Installing gh extensions..."
gh extension install github/gh-copilot 2>/dev/null || true

# ── Done ──────────────────────────────────────────────────────────────────────

echo ""
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "  1. source ~/.zshrc         (reload shell)"
echo "  2. gh auth login           (authenticate GitHub)"
echo "  3. Open OrbStack from Applications"
echo ""
