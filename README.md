# dotfiles

This repo holds configuration files for tooling I use regularly while working on MacOS.

## Usage

1. be sure you have git installed

```sh
xcode-select --install
```

2. clone the repo

```sh
git clone git@github.com:radlinskii/dotfiles.git
```

3. once inside the repo's folder run the install script

```sh
./scripts/install.sh
```

4. manually adjust the git config

```sh
git config --global core.excludesfile ~/.gitignore_global
git config --global init.defaultBranch main
git config --global user.name "Your Name"
git config --global user.email "Your Email"
```

To add nvim as `difftool` and `mergetool` add:

```
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

5. put local-machine-specific shell configuration and secret env vars in `~/.local_zshrc.sh`

```sh
nvim ~/.local_zshrc.sh
```

## Acknowledgements

-   Nick Nisi's [dotfiles](https://github.com/nicknisi/dotfiles)

## License

MIT - see [LICENSE](LICENSE) file
