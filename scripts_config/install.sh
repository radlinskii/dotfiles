#!/usr/bin/env zsh

script_dir="${0:A:h}"

failed_operations=()

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

    local source="${1:A}"
    local destination_directory="$2"

    if [[ ! -d "$source" && ! -f "$source" ]]; then
        echo "${Red}Source does not exist: $source${NoColor}"
        failed_operations+=("Source does not exist: $source")
        return
    fi

    if [[ ! -d "$destination_directory" ]]; then
        echo "${Orange}Destination directory does not exist: $destination_directory${NoColor}"
        echo "${Blue}Creating destination directory $destination_directory${NoColor}"
        mkdir -p "$destination_directory"
        if [[ $? -ne 0 ]]; then
            failed_operations+=("Failed to create directory: $destination_directory")
        fi
    fi

    if [[ -f "$source" ]]; then
        local file_name="$(basename "$source")"
        local destination="$destination_directory/$file_name"

        echo "Creating symlink for file $source to $destination"
        ln -sf "$source" "$destination"
        if [[ $? -ne 0 ]]; then
            failed_operations+=("Failed to create symlink: $source -> $destination")
        fi

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
    local terms=(${(s: :)1}) # Split terms into an array
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
    echo "${Blue}\nCreating symlinks\n${NoColor}"

echo "${Blue}Removing existing ~/.config/wezterm${NoColor}"
    rm -rf "$HOME/.config/wezterm"
    echo "${Blue}Creating symlink for wezterm${NoColor}"
    create_symlinks "$script_dir/../wezterm_config" "$HOME/.config/wezterm"
    echo "${Blue}Creating symlink for zsh${NoColor}"
    create_symlinks "$script_dir/../zsh_config" "$HOME"
    echo "${Blue}Creating symlink for git${NoColor}"
    create_symlinks "$script_dir/../git_config" "$HOME"
    echo "${Blue}Creating symlink for tmux${NoColor}"
    create_symlinks "$script_dir/../tmux_config" "$HOME"
    echo "${Blue}Removing existing ~/.config/nvim${NoColor}"
    rm -rf "$HOME/.config/nvim"
    echo "${Blue}Creating symlink for nvim${NoColor}"
    create_symlinks "$script_dir/../nvim_config" "$HOME/.config/nvim"

    # macOS
    if [[ "$os" == "Darwin" ]]; then
        echo "${Blue}Creating symlink for superfile${NoColor}"
        create_symlinks "$script_dir/../superfile_config" "$HOME/Library/Application Support/superfile"
        echo "${Blue}Creating symlink for lazygit${NoColor}"
        create_symlinks "$script_dir/../lazygit_config" "$HOME/Library/Application Support/lazygit"
    fi

    # Linux
    if [[ "$os" == "Linux" ]]; then
        echo "${Blue}Creating symlink for superfile${NoColor}"
        create_symlinks "$script_dir/../superfile_config" "$HOME/.config/superfile"
        echo "${Blue}Creating symlink for lazygit${NoColor}"
        create_symlinks "$script_dir/../lazygit_config" "$HOME/.config/lazygit"
    fi

    # Linux
    if [[ "$os" == "Linux" ]]; then
        echo "Creating symlink for superfile"
        create_symlinks "$script_dir/../superfile_config" "$HOME/.config/superfile"

        echo "Creating symlink for lazygit"
        create_symlinks "$script_dir/../lazygit_config" "$HOME/.config/lazygit"
    fi
fi

# macOS
if [[ "$os" == "Darwin" ]]; then
    if has_param "-m --mac" "$@" || [[ $# -eq 0 ]]; then
        echo "${Blue}\nConfiguring macOS\n${NoColor}"

        "$script_dir/macos.sh"
    fi

    if has_param "-b --brew" "$@" || [[ $# -eq 0 ]]; then
        echo "${Blue}\nSetting up Homebrew\n${NoColor}"

        "$script_dir/brew.sh"
    fi
fi

if [[ ${#failed_operations[@]} -gt 0 ]]; then
    echo "${Red}\nFailed operations:\n${NoColor}"
    for item in "${failed_operations[@]}"; do
        echo "  - $item"
    done
else
    echo "${Green}All operations completed successfully${NoColor}"
fi
