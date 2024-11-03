#!/bin/zsh

alias fzfm="fzf --multi"

function tmx() {
  local session_name="${1:-main}"

  # Check if the session already exists
  if ! tmux has-session -t "$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name"
  fi

  # Check if the "btop" window exists in the session
  if ! tmux list-windows -t "$session_name" | grep -q "btop"; then
    # Create the "btop" window if it doesn't exist
    tmux new-window -t "$session_name" 'btop'
  fi

  # Attach to the session, the first window is active
  tmux select-window -t "$session_name:1"
  # Reload config to load battery and cpu plugins
  tmux source-file ~/.tmux.conf
  tmux attach-session -t "$session_name"
}

alias x="exit"

alias sz="source ~/.zshrc"

alias dirs="dirs -v" # show directory stack with index

alias checka="alias | grep"

# VSCode
alias c="code-insiders"
alias code="code-insiders"

# NPM
alias npmd="npm run dev"

# HISTORY
alias checkh="history | grep"
function h() {
    if [ "$1" = "-c" ]; then
        echo "don't even fucking try to remove my history"
    else
        history
    fi
}

# check port
function checkp() {
    lsof -i :"$1"
}

# move a file from one location to another
# and create a symbolic link in it's place in the first location
function mvln() {
    mv -- "$1" "$2"
    ln -s -- "$2" "$1"
}

# kill process running on given port
function killp() {
    local tmp
    local exit_status

    echo "looking for process running on port: $1"
    tmp=$(lsof -i :"$1" | awk '{ print $2}' | grep "^[0-9][0-9]*$")
    exit_status=$?

    if [ $exit_status -ne 0 ]; then
        echo "\e[41munable to find the process!\e[0m"
    else
        echo "trying to kill process: $tmp"
        kill -9 "$tmp"
        exit_status=$?

        if [ $exit_status -ne 0 ]; then
            echo "\e[41munable to kill the process!\e[0m"
        else
            echo "\e[30;48;5;82msuccessfully killed the process!\e[0m"
        fi
    fi

    echo "exit status: $exit_status"
    return $exit_status
}

# Define the fcd function
fcd() {
    # Accept 1 argument that's a string key, and perform a different
    # "cd" operation for each key.
    case "$1" in
    projects)
        cd $HOME/Projects
        ;;
    config)
        cd $HOME/.config
        ;;
    *)
        # The supplied argument was not one of the supported keys
        echo "fcd: unknown key '$1'"
        return 1
        ;;
    esac
    # Helpfully print the current directory name to indicate where you are
    pwd
}

# Set up tab completion
complete -W "projects config" fcd

# Use Neovim instead of Vim or Vi
alias vim=nvim
alias vi=nvim


# GIT
alias gback="git reset HEAD^"
alias gitback="git reset head^"

alias gdt='git difftool'
alias gdtca='git difftool --cached'
alias gdtcw='git difftool --cached --word-diff'
alias gdts='git difftool --staged'
alias gdtr='git diff-tree --no-commit-id --name-only -r'
alias gdtup='git difftool @{upstream}'
alias gdtw='git difftool --word-diff'

