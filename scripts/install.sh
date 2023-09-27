#!/bin/zsh

emulate -LR bash

create_symlinks() {
    local source="$1"
    local destination_directory="$2"

    if [[ ! -d "$source" && ! -f "$source" ]]; then
        echo "Source does not exist: $source"
        return
    fi

    if [[ ! -d "$destination_directory" ]]; then
        echo "Destination directory does not exist: $destination_directory"
        echo "Creating destination directory $destination_directory"
        mkdir -p $destination_directory
    fi

    if [[ -f "$source" ]]; then
        local file_name="$(basename "$file")"
        local source="$(pwd)/$file"
        local destination="$destination_directory/$file_name"

        echo "Creating symlink for file $source to $destination"
        ln -sf "$source" "$destination"

    fi

    if [[ -d "$source" ]]; then
        for file in "$source"/{.[!.]*,*}; do
            if [[ -f "$file" ]]; then
                create_symlinks "$file" "$destination_directory"
            fi

            if [[ -d "$file" ]]; then
                create_symlinks "$file" "$destination_directory/$(basename "$file")"
            fi
        done
    fi
}

echo "Creating symlinks"

create_symlinks "wezterm" "$HOME/.config/wezterm"

create_symlinks "less" "$HOME"

create_symlinks "zsh" "$HOME"

create_symlinks "git" "$HOME"

create_symlinks "nvim_chad_custom" "$HOME/.config/nvim/lua/custom"

# setup macos defaults
./scripts/macos.sh

# setup Homebrew
./scripts/brew.sh

# install om-my-zsh
if [[ ! -d "$ZSH" ]]; then
    echo "Installing oh-my-zsh"
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
else
    echo "Omitting oh-my-zsh installation"
    echo "$ZSH directory already exists"
fi
