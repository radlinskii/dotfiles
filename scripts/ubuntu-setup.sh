mkdir -p ~/.local/bin
# add local bin to PATH
export PATH=$PATH:$HOME/.local/bin

# install zsh, switch to it
sudo apt install zsh -y
zsh
chsh -s $(which zsh)

# install more deps
sudo apt install git-all -y
sudo apt install zoxide -y
sudo apt install lazygit -y
sudo apt install build-essential  -y
sudo apt install btop -y
sudo apt install unzip -y

# sudo apt install python3 -y
# sudo apt install python3-pip -y
# needed by djlint linter for nvim
sudo apt install python3-venv -y

sudo apt install fd-find
ln -s $(which fdfind) ~/.local/bin/fd

sudo apt install bat -y
ln -s $(which batcat) ~/.local/bin/bat

# ohmyzsh
# sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# fzf
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# ~/.fzf/install

# nerd font
# wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/IosevkaTerm.zip \
# && cd ~/.local/share/fonts \
# && unzip IosevkaTerm.zip \
# && rm IosevkaTerm.zip \
# && fc-cache -fv

# fix freezing
# sudo nvim /etc/default/grub
# GRUB_CMDLINE_LINUX_DEFAULT="nomodeset consoleblank=90"

