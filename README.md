# dotfiles

This repo holds configuration files for tooling I use regularly while working on MacOS.

> Neovim and some other parts of the setup are also used on Windows.

## Usage

### 1. be sure you have git installed

```sh
xcode-select --install
```

### 2. clone the repo

```sh
git clone git@github.com:radlinskii/dotfiles.git
```

### 3. once inside the repo's folder run the install script

```sh
./scripts/install.sh
```

To only run parts of `install.sh` responsible for specific configurations pass flags to it:

- for linking config files run it with flag `-l` or `--link`.
- to only configure `MacOS` specific settings run it with flag `-m` or `--mac`.
- to only install `Homebrew` packages run it with flag `-b` or `--brew`.
- to install `oh-my-zsh` use `-o` or `--omz` flag.

Example usage: `./scripts/install.sh -l -b`

### 4. manually adjust the git config

```sh
git config --global core.excludesfile ~/.gitignore_global
git config --global user.name "Your Name"
git config --global user.email "Your Email"
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global push.autoSetupRemote true
```

To add nvim as `difftool` and `mergetool` add:

```ini
[diff]
    tool = nvimdiff
[difftool]
    prompt = false
[difftool "nvimdiff"]
    cmd = "nvim -d \"$LOCAL\" \"$REMOTE\""
[merge]
    tool = nvimdiff
[mergetool]
    prompt = true
[mergetool "nvimdiff"]
    cmd = "nvim -d \"$LOCAL\" \"$REMOTE\" \"$MERGED\" -c 'wincmd w' -c 'wincmd J'"
```

to the `.gitconfig` file

### 5. put local-machine-specific shell configuration and secret env vars in `~/.local_zshrc.sh`

```sh
nvim ~/.local_zshrc.sh
```

### 6. Even more tooling

Other tools to install, also can be found in `Brewfile`:

`zsh`, `omz`, `zoxide`, `fzf`, `ripgrep`, `bat`, `tmux`, `lazygit`, `btop`, `superfile`, `unzip`, `fd`, `tldr`, `tree`

and more:

`shfmt`, `luarocks`, `eslint_d`

Other environments to setup:

[node & npm](https://nodejs.org/en/download/package-manager), [go](https://go.dev/doc/install), [rust](https://www.rust-lang.org/tools/install), and from whatever you can find it `python`.

### 7. [lazygit](https://github.com/jesseduffield/lazygit) setup within nvim using [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) might require [neovim-remote](https://github.com/mhinz/neovim-remote)

Setting up `nvr` might require assigning evironment variable `NVIM_LISTEN_ADDRESS`.
Value could be `localhost:6789` as it is the default value that `nvr` tries to connect to.

## Acknowledgements

- Nick Nisi's [dotfiles](https://github.com/nicknisi/dotfiles)

## License

MIT - see [LICENSE](LICENSE) file
