#!/bin/zsh

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

# GIT
alias gback="git reset HEAD^"
alias gitback="git reset HEAD^"

# function set_git_config_variable() {
#     local defaultvalue="$(git config user.$1)"
#     local exit_status

#     echo "Please provide the repository config user $1 (default: $defaultvalue):"
#     read customvalue

#     if [ -z $customvalue ]; then
#         git config user.$1 $defaultvalue
#         exit_status=$?
#     else
#         git config user.$1 $customvalue
#         exit_status=$?
#     fi

#     if [ $exit_status -ne 0 ]; then
#         echo "Error occured while setting the repository config user $1."
#         return $exit_status
#     fi

#     return 0
# }
# function git() {
#     local tmp=$(mktemp -t git)
#     local repo_name
#     local exit_status
#     local quiet_flag=$(echo "$@" | grep "\ -q\|\ --quiet")

#     if [ "$1" = clone ] || [ "$1" = init ] && [ "$2" != --help ] && [ -z "$quiet_flag" ]; then
#         command git "$@" 2>&1 | tee $tmp

#         if [ -n "$(awk '/error:|fatal:|usage:/ {print $0}' $tmp)" ]; then
#             rm $tmp
#             return 1
#         fi

#         if [ "$1" = init ]; then
#             repo_name=$(awk '/Initialized empty Git repository in/ {print $6}' $tmp)
#             repo_name=$(echo ${repo_name/\/\.git\/})
#         elif [ "$1" = clone ]; then
#             repo_name=$(awk -F\' '/Cloning into/ {print $2}' $tmp)
#         fi

#         rm $tmp
#         printf "Changing directory to '%s'\n" "$repo_name"
#         cd "$repo_name"

#         exit_status=$?
#         if [ $exit_status -ne 0 ]; then
#             echo "Error occured while changing current directory to the local repository directory."
#             return $exit_status
#         fi

#         set_git_config_variable "name"
#         exit_status=$?
#         if [ $exit_status -ne 0 ]; then
#             return $exit_status
#         fi

#         set_git_config_variable "email"
#         exit_status=$?

#         return $exit_status
#     else
#         command git "$@"
#     fi
# }

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
