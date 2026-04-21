script_dir="${0:A}"
script_dir="$(dirname "$script_dir")"
brewfile_path="$script_dir/../Brewfile"

# install brew dependencies from Brewfile
brew bundle install --file="$brewfile_path"

# install fzf
# echo "Installing fzf"
# "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
