# dotfiles

This repo holds configuration files for tooling I use.

## Usage

WIP...

todo:

-   [ ] homebrew setup
-   [ ] oh-my-zsh setup

1. be sure you have git installed

```sh
xcode-select --install
```

2. clone the repo

```sh
gh repo clone git@github.com:radlinskii/dotfiles.git
```

3. run the install script

```sh
./scripts/install.sh
```

4. manually add git username and email to global config

```sh
git config --global user.name "Your Name"
git config --global user.email "Your Email"
```

5. To use global `.gitignore` file add the following to the `~/.gitconfig` file

```
[core]
	excludesfile = /Users/{YOUR_USER_NAME}/.gitignore_global
```

## Acknowledgements

-   Nick Nisi's [dotfiles](https://github.com/nicknisi/dotfiles)
