create_symlink() {
    local file="$1"
    local destination_directory="$2"

    if [[ -f "$file" ]]; then
        local source="$(pwd)/$file"
        local destination="$destination_directory/$(basename "$file")"

        echo "Creating symlink for $source to $destination"
        ln -sf "$source" "$destination"
    fi
}

create_symlinks() {
    local source_directory="$1"
    local destination_directory="$2"

    if [[ ! -d "$source_directory" ]]; then
        echo "Source directory does not exist: $source_directory"
        return
    fi

    for file in "$source_directory"/*; do
        if [[ -f "$file" ]]; then
            local file_name="$(basename "$file")"
            local source="$(pwd)/$file"
            local destination="$destination_directory/$file_name"

            echo "Creating symlink for $source to $destination"
            ln -sf "$source" "$destination"
        fi
    done
}

echo "Creating symlinks";

create_symlink "wezterm/wezterm.lua" "$HOME/.config/wezterm";

create_symlink "less/.lesskey" "$HOME";

create_symlink "neovim/init.lua" "$HOME/.config/nvim";

create_symlink "zsh/.custom_aliases" "$HOME";
create_symlink "zsh/.custom_bindings" "$HOME";
create_symlink "zsh/.zshrc" "$HOME";

create_symlink "git/.gitignore_global" "$HOME";

mkdir -p "$HOME/.config/nvim/lua/custom"
create_symlinks "nvim_chad_custom" "$HOME/.config/nvim/lua/custom"
mkdir -p "$HOME/.config/nvim/lua/custom/configs"
create_symlinks "nvim_chad_custom/configs" "$HOME/.config/nvim/lua/custom/configs"

# setup macos defaults
./scripts/macos.sh;
