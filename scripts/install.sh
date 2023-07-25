
# Change to the directory containing this script
# cd "$(dirname "${BASH_SOURCE[0]}")"

# Create symlinks for each file in the wezterm folder in the home directory
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

echo "Creating symlinks";

create_symlink "wezterm/wezterm.lua" "$HOME/.config/wezterm";

create_symlink "less/.lesskey" "$HOME";

create_symlink "zsh/.custom_aliases" "$HOME";
create_symlink "zsh/.custom_bindings" "$HOME";
create_symlink "zsh/.zshrc" "$HOME";

create_symlink "git/.gitignore_global" "$HOME";

# setup macos defaults
./scripts/macos.sh;
