#!/usr/bin/env zsh

Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Orange='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
LightGray='\033[0;37m'
DarkGray='\033[1;30m'
LightRed='\033[1;31m'
LightGreen='\033[1;32m'
Yellow='\033[1;33m'
LightBlue='\033[1;34m'
LightPurple='\033[1;35m'
LightCyan='\033[1;36m'
White='\033[1;37m'
NoColor='\033[0m'

create_symlinks() {
    setopt nullglob

    local source="$1"
    local destination_directory="$2"
    if [[ ! -d "$source" && ! -f "$source" ]]; then
        echo "${Red}Source does not exist: $source${NoColor}"
        return
    fi

    if [[ ! -d "$destination_directory" ]]; then
        echo "${Red}Destination directory does not exist: $destination_directory${NoColor}"
        echo "${Blue}Creating destination directory $destination_directory${NoColor}"
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
        for file in "$source"/{*,.[!.]*}; do
            if [[ -f "$file" ]]; then
                create_symlinks "$file" "$destination_directory"
            elif [[ -d "$file" && "$file" != "$source" ]]; then
                create_symlinks "$file" "$destination_directory/$(basename "$file")"
            fi
        done
    fi

    unsetopt nullglob
}

function has_param() {
    local terms=(${(s: :)1})  # Split terms into an array
    shift

    for term in "${terms[@]}"; do
        for arg; do
            if [[ $arg == "$term" ]]; then
                return 0
            fi
        done
    done

    return 1
}

os=$(uname -s)

if has_param "-l --link" "$@" || [[ $# -eq 0 ]]; then
    echo "${Blue}Creating symlinks${NoColor}"

    create_symlinks "wezterm_config" "$HOME/.config/wezterm"
    create_symlinks "zsh_config" "$HOME"
    create_symlinks "git_config" "$HOME"
    create_symlinks "tmux_config" "$HOME"
    create_symlinks "nvim_config" "$HOME/.config/nvim"


    # macOS
    if [[ "$os" == "Darwin" ]]; then
        create_symlinks "superfile_config" "$HOME/Library/Application Support/superfile"
        create_symlinks "lazygit_config" "$HOME/Library/Application Support/lazygit"
    fi

    # Linux
    if [[ "$os" == "Linux" ]]; then
        create_symlinks "superfile_config" "$HOME/.config/superfile"
        create_symlinks "lazygit_config" "$HOME/.config/lazygit"
    fi
fi

# macOS
if [[ "$os" == "Darwin" ]]; then
    if has_param "-m --mac" "$@" || [[ $# -eq 0 ]]; then
        echo "${Blue}Configuring macOS${NoColor}"

        ./scripts_config/macos.sh
    fi

    if has_param "-b --brew" "$@" || [[ $# -eq 0 ]]; then
        echo "${Blue}Setting up Homebrew${NoColor}"

        ./scripts_config/brew.sh
    fi
fi

