mkdir -p ~/.local/bin
export PATH=$PATH:$HOME/.local/bin

sudo apt install zsh -y
if command -v zsh &>/dev/null; then
    sudo chsh -s "$(which zsh)" 2>/dev/null || true
fi

sudo apt install git-all -y
sudo apt install zoxide -y
sudo apt install lazygit -y
sudo apt install curl wget fzf -y
sudo apt install build-essential -y
sudo apt install btop -y
sudo apt install unzip -y
sudo apt install tmux -y
sudo apt install fontconfig -y

# sudo apt install python3 -y
# sudo apt install python3-pip -y
# needed by djlint linter for nvim
# sudo apt install python3-venv -y

sudo apt install fd-find -y
if command -v fdfind &>/dev/null; then
    ln -sf "$(which fdfind)" ~/.local/bin/fd
fi

sudo apt install bat -y
sudo apt install jq -y
if command -v batcat &>/dev/null; then
    ln -sf "$(which batcat)" ~/.local/bin/bat
fi

# oh-my-zsh (only if not already installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# zsh plugins/themes (only if not already cloned)
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ -d "$ZSH_CUSTOM/themes/Chill" ] || \
    git clone https://github.com/JKerboeuf/chill.zsh-theme.git "$ZSH_CUSTOM/themes/Chill"
