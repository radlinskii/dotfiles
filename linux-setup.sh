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
mkdir -p "$HOME/.local/bin"
export PATH=$PATH:$HOME/.local/bin

sudo apt install -y zsh git-all zoxide lazygit curl wget fzf build-essential btop unzip tmux fontconfig fd-find bat jq

# sudo apt install -y python3 python3-pip python3-venv # needed by djlint linter for nvim

if command -v zsh &>/dev/null; then
    sudo chsh -s "$(which zsh)" 2>/dev/null || true
fi
if command -v fdfind &>/dev/null; then
    ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
fi
if command -v batcat &>/dev/null; then
    ln -sf "$(which batcat)" "$HOME/.local/bin/bat"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ -d "$ZSH_CUSTOM/themes/Chill" ] || \
    git clone https://github.com/JKerboeuf/chill.zsh-theme.git "$ZSH_CUSTOM/themes/Chill"

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

# 9. Ensure XDG_RUNTIME_DIR exists for nvim (fzf-lua needs it for serverstart)
# LXC containers running as root don't create /run/user/0 by default
mkdir -p /run/user/0

# 10. Save Proxmox container info for shell prompt (if provided via env vars)
if [ -n "${CT_ID:-}" ] && [ -n "${PROXMOX_HOST:-}" ]; then
    mkdir -p /etc/profile.d
    cat > /etc/profile.d/proxmox-prompt.sh <<- PROMPT_EOF
export PROXMOX_CT_ID=$CT_ID
export PROXMOX_HOST=$PROXMOX_HOST
PROMPT_EOF
fi
