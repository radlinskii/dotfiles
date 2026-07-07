#!/usr/bin/env bash
set -euo pipefail

# 1. Install git if missing
if ! command -v git &>/dev/null; then
    apt update && apt install git -y
fi

# 2. Clone repo
REPO_DIR="$HOME/dotfiles"
if [ ! -d "$REPO_DIR" ]; then
    git clone --branch proxmox https://github.com/radlinskii/dotfiles.git "$REPO_DIR"
fi

cd "$REPO_DIR"

# 3. Install packages, ohmyzsh, fzf
bash scripts_config/ubuntu-setup.sh

# 4. Create cspell config (needed by nvim-lint)
if [ ! -f "$HOME/.cspell.json" ]; then
    cat > "$HOME/.cspell.json" << 'EOF'
{"flagWords":[],"version":"0.2","words":[]}
EOF
fi

# 5. Symlink configs
mkdir -p "$HOME/.config"
zsh scripts_config/install.sh -l

# 6. Install nvm + Node LTS
export NVM_DIR="$HOME/.nvm"
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm ls default &>/dev/null || nvm install --lts

# 7. Install neovim from GitHub releases (if not already present)
# /opt/nvim/bin is already added to PATH in .zshrc
if [ ! -x /opt/nvim/bin/nvim ]; then
    mkdir -p /opt/nvim
    curl -fsSL https://github.com/neovim/neovim/releases/download/v0.12.4/nvim-linux-x86_64.tar.gz \
      | tar xzf - -C /opt/nvim --strip-components=1
fi

# 8. Install tree-sitter CLI (if not already installed)
npm ls -g tree-sitter-cli &>/dev/null || npm install -g tree-sitter-cli
