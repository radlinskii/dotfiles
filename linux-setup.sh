#!/usr/bin/env bash
# Dotfiles setup for Debian/Ubuntu machines (Proxmox LXC containers, VMs, servers).
# Safe to re-run. Works as root (no sudo needed) or as a sudo-capable user.
#
#   CT_ID=<id> PROXMOX_HOST=<host> bash linux-setup.sh   # from `pct exec`
#   UPDATE_TOOLS=1 bash linux-setup.sh                    # also upgrade fzf/lazygit/rg to latest
set -euo pipefail

# Never open a pager (git log/diff would wait for `q` when run from a terminal).
export GIT_PAGER=cat PAGER=cat

WARNINGS=()
step() { printf '\n\033[1;35m### %s\033[0m\n' "$*"; }                 # section header
log()  { printf '\033[1;34m==> %s\033[0m\n' "$*"; }                   # doing something
ok()   { printf '\033[1;32m OK %s\033[0m\n' "$*"; }                   # already in place / done
warn() { printf '\033[1;33m !! %s\033[0m\n' "$*" >&2; WARNINGS+=("$*"); }

# ---------------------------------------------------------------- 0. environment
step "Environment"
if [ "$(id -u)" -eq 0 ]; then
    SUDO=""
elif command -v sudo &>/dev/null; then
    SUDO="sudo"
else
    echo "Run as root or install sudo first." >&2
    exit 1
fi

if [ -r /etc/os-release ]; then
    . /etc/os-release
fi
log "OS: ${PRETTY_NAME:-unknown}  arch: $(uname -m)  user: $(id -un)  home: $HOME  sudo: ${SUDO:-not needed (root)}"
case "${ID:-} ${ID_LIKE:-}" in
    *debian*|*ubuntu*) ;;
    *) warn "Not a Debian/Ubuntu system (ID=${ID:-?}); apt steps will likely fail." ;;
esac

case "$(uname -m)" in
    x86_64)        ARCH_GO=amd64; ARCH_LG=x86_64; ARCH_RG=x86_64-unknown-linux-musl;  ARCH_NVIM=x86_64 ;;
    aarch64|arm64) ARCH_GO=arm64; ARCH_LG=arm64;  ARCH_RG=aarch64-unknown-linux-gnu; ARCH_NVIM=arm64 ;;
    *) echo "Unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac

export DEBIAN_FRONTEND=noninteractive
# shellcheck disable=SC2206  # $SUDO is empty or "sudo"
APT=($SUDO apt-get -y -q -o DPkg::Lock::Timeout=300)

# Tools from GitHub releases go here. /usr/local/bin comes before /usr/bin in PATH,
# so they win over an older apt copy of the same tool.
BIN_DIR=/usr/local/bin

# ---------------------------------------------------------------- helpers
is_installed() { dpkg-query -W -f '${Status}' "$1" 2>/dev/null | grep -q 'install ok installed'; }

# Install only the packages this release actually has, so one missing package
# (e.g. btop on Debian 11) doesn't abort the whole apt transaction.
apt_install_available() {
    local installed=() to_install=() missing=() pkg
    for pkg in "$@"; do
        if is_installed "$pkg"; then installed+=("$pkg")
        elif apt-cache show "$pkg" &>/dev/null; then to_install+=("$pkg")
        else missing+=("$pkg"); fi
    done
    [ ${#installed[@]} -eq 0 ] || ok "already installed: ${installed[*]}"
    [ ${#missing[@]} -eq 0 ]   || warn "not in apt on this release, skipped: ${missing[*]}"
    if [ ${#to_install[@]} -gt 0 ]; then
        log "installing: ${to_install[*]}"
        "${APT[@]}" install --no-install-recommends "${to_install[@]}"
        ok "installed: ${to_install[*]}"
    fi
}

# Latest release tag of a GitHub repo, without a leading "v" (follows the redirect, no API rate limit).
gh_latest() {
    curl -fsSLI -o /dev/null -w '%{url_effective}' "https://github.com/$1/releases/latest" \
        | sed -E 's#.*/tag/v?##'
}

# version_ge A B  ->  true if A >= B
version_ge() { [ "$(printf '%s\n%s\n' "$2" "$1" | sort -V | head -n1)" = "$2" ]; }

# Download a .tar.gz and install binary NAME (found anywhere in the archive) to BIN_DIR.
install_from_tarball() {
    local url=$1 name=$2 tmp
    log "downloading $url"
    tmp=$(mktemp -d)
    curl -fsSL "$url" | tar xzf - -C "$tmp"
    $SUDO install -m 0755 "$(find "$tmp" -type f -name "$name" | head -n1)" "$BIN_DIR/$name"
    rm -rf "$tmp"
}

fzf_version()     { fzf --version | awk '{print $1}'; }
lazygit_version() { lazygit --version | grep -oE '(^|, )version=[0-9.]+' | head -n1 | cut -d= -f2; }
rg_version()      { rg --version | awk 'NR==1 {print $2}'; }

install_fzf() {
    local v; v=$(gh_latest junegunn/fzf)
    install_from_tarball "https://github.com/junegunn/fzf/releases/download/v$v/fzf-$v-linux_$ARCH_GO.tar.gz" fzf
}
install_lazygit() {
    local v; v=$(gh_latest jesseduffield/lazygit)
    install_from_tarball "https://github.com/jesseduffield/lazygit/releases/download/v$v/lazygit_${v}_Linux_$ARCH_LG.tar.gz" lazygit
}
install_rg() {
    local v; v=$(gh_latest BurntSushi/ripgrep)   # ripgrep tags have no "v"
    install_from_tarball "https://github.com/BurntSushi/ripgrep/releases/download/$v/ripgrep-$v-$ARCH_RG.tar.gz" rg
}

# ensure_tool CMD MIN_VERSION
# Installs CMD from GitHub (install_CMD) if it's missing, older than MIN_VERSION, or UPDATE_TOOLS=1.
ensure_tool() {
    local cmd=$1 min=$2 current=""
    if command -v "$cmd" &>/dev/null; then current=$("${cmd}_version" 2>/dev/null || true); fi
    if [ -n "$current" ] && version_ge "$current" "$min" && [ -z "${UPDATE_TOOLS:-}" ]; then
        ok "$cmd $current (>= $min) at $(command -v "$cmd")"
        return
    fi
    if [ -n "${UPDATE_TOOLS:-}" ] && [ -n "$current" ]; then
        log "$cmd $current: updating to the latest GitHub release (UPDATE_TOOLS=1)"
    elif [ -n "$current" ]; then
        log "$cmd $current is older than $min: installing the latest GitHub release"
    else
        log "$cmd not found: installing the latest GitHub release"
    fi
    "install_$cmd"
    hash -r
    ok "$cmd $("${cmd}_version" 2>/dev/null || echo '?') at $(command -v "$cmd")"
}

# link_if_missing TARGET_CMD LINK_NAME  (Debian ships fd/bat as fdfind/batcat)
link_if_missing() {
    if command -v "$2" &>/dev/null; then
        ok "$2 -> $(readlink -f "$(command -v "$2")")"
    elif command -v "$1" &>/dev/null; then
        ln -sf "$(command -v "$1")" "$HOME/.local/bin/$2"
        ok "linked $HOME/.local/bin/$2 -> $(command -v "$1")"
    else
        warn "neither $2 nor $1 found, no $2 command"
    fi
}

clone_if_missing() {
    if [ -d "$2" ]; then
        ok "$(basename "$2") already at $2"
    else
        log "cloning $1"
        git clone -q --depth 1 "$1" "$2"
        ok "$(basename "$2") cloned to $2"
    fi
}

# ---------------------------------------------------------------- 1. base packages
step "Base packages"
log "apt update"
"${APT[@]}" update
apt_install_available ca-certificates curl git tar gzip

# ---------------------------------------------------------------- 2. clone / update repo
step "Dotfiles repo"
REPO_DIR="$HOME/dotfiles"
NVIM_LOCK=nvim_config/nvim-pack-lock.json   # relative to REPO_DIR
if [ ! -d "$REPO_DIR/.git" ]; then
    log "cloning dotfiles (branch proxmox) to $REPO_DIR"
    git clone -q --branch proxmox https://github.com/radlinskii/dotfiles.git "$REPO_DIR"
    ok "cloned at $(git -C "$REPO_DIR" log -1 --format='%h %s')"
else
    # The clone here only mirrors the proxmox branch, which gets rebased onto main and
    # force-pushed, so a plain pull often can't fast-forward. With a clean working tree
    # we just move to origin/proxmox; the old state is kept as a backup branch.
    g() { git -C "$REPO_DIR" "$@"; }
    upstream=origin/proxmox
    before=$(g rev-parse --short HEAD)
    g fetch -q origin
    # Neovim rewrites the lockfile (symlinked into this repo) on every plugin install/update.
    # The repo's lockfile is the source of truth; plugins are synced to it in the "Neovim plugins" step.
    if [ -n "$(g status --porcelain -- "$NVIM_LOCK")" ]; then
        g checkout -q -- "$NVIM_LOCK"
        ok "discarded local changes to $NVIM_LOCK (plugins get synced to the repo's lockfile later)"
    fi
    dirty=$(g status --porcelain --untracked-files=no)
    if g merge-base --is-ancestor HEAD "$upstream"; then
        if [ -n "$dirty" ] && [ "$(g rev-parse HEAD)" != "$(g rev-parse "$upstream")" ]; then
            g merge -q --ff-only "$upstream" \
                || warn "uncommitted changes in $REPO_DIR block the update, using it as is at $before"
        else
            g merge -q --ff-only "$upstream"
        fi
        after=$(g rev-parse --short HEAD)
        if [ "$before" = "$after" ]; then ok "$REPO_DIR up to date ($after)"
        else ok "$REPO_DIR updated $before -> $after"; fi
    elif [ -z "$dirty" ]; then
        backup="backup/$(date +%Y%m%d-%H%M%S)"
        g branch "$backup"
        g reset -q --hard "$upstream"
        ok "$upstream was rewritten (rebase/force-push): moved $before -> $(g rev-parse --short HEAD)"
        ok "old state kept as branch $backup; commits it had that aren't on $upstream:"
        g log --format='      %h %s' "$upstream..$backup"
    else
        # shellcheck disable=SC2001
        warn "$REPO_DIR can't be updated: $upstream was rewritten and there are uncommitted changes:"$'\n'"$(sed 's/^/      /' <<<"$dirty")"$'\n'"      using it as is at $before. To drop them: git -C $REPO_DIR reset --hard $upstream"
    fi
fi
cd "$REPO_DIR"

# ---------------------------------------------------------------- 3. packages
step "Packages"
mkdir -p "$HOME/.local/bin"
export PATH="$BIN_DIR:$PATH:$HOME/.local/bin"

# fzf, lazygit and ripgrep deliberately NOT from apt: missing on some releases, too old on others.
apt_install_available zsh tree wget build-essential btop unzip tmux fontconfig fd-find bat jq zoxide

# apt_install_available python3 python3-pip python3-venv # needed by djlint linter for nvim

step "fzf / lazygit / ripgrep"
# fzf >= 0.48 is needed for `source <(fzf --zsh)` in .zshrc; the other minimums are just "not ancient".
ensure_tool fzf     0.48
ensure_tool lazygit 0.40
ensure_tool rg      13.0

step "fd / bat names"
link_if_missing fdfind fd
link_if_missing batcat bat

step "Login shell"
# chsh for the current user explicitly (a bare `sudo chsh` would change root's shell instead).
ZSH_BIN=$(command -v zsh || true)
current_shell=$(getent passwd "$(id -un)" | cut -d: -f7)
if [ -z "$ZSH_BIN" ]; then
    warn "zsh not installed, login shell stays $current_shell"
elif [ "$current_shell" = "$ZSH_BIN" ]; then
    ok "login shell is already $ZSH_BIN"
elif $SUDO chsh -s "$ZSH_BIN" "$(id -un)"; then
    ok "login shell changed $current_shell -> $ZSH_BIN"
else
    warn "chsh failed, change the login shell manually (currently $current_shell)"
fi

# ---------------------------------------------------------------- 4. oh-my-zsh + plugins
step "oh-my-zsh"
if [ -d "$HOME/.oh-my-zsh" ]; then
    ok "oh-my-zsh already at $HOME/.oh-my-zsh"
else
    log "installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    ok "oh-my-zsh installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions     "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/JKerboeuf/chill.zsh-theme         "$ZSH_CUSTOM/themes/Chill"

# ---------------------------------------------------------------- 5. cspell config (nvim-lint)
step "cspell config"
if [ -f "$HOME/.cspell.json" ]; then
    ok "$HOME/.cspell.json exists"
else
    echo '{"flagWords":[],"version":"0.2","words":[]}' > "$HOME/.cspell.json"
    ok "created $HOME/.cspell.json"
fi

# ---------------------------------------------------------------- 6. symlink configs
step "Config symlinks"
mkdir -p "$HOME/.config"
zsh scripts_config/install.sh -l

# ---------------------------------------------------------------- 7. nvm + Node LTS + tree-sitter CLI
step "nvm / Node / tree-sitter CLI"
# PROFILE=/dev/null: .zshrc already loads nvm, don't let the installer append to the symlinked rc files.
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    nvm_status="already"
else
    log "installing nvm"
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | PROFILE=/dev/null bash
    nvm_status="installed"
fi
set +u   # nvm isn't `set -u` safe
. "$NVM_DIR/nvm.sh"
ok "nvm $(nvm --version) $nvm_status at $NVM_DIR"
if nvm ls default &>/dev/null; then
    ok "Node $(node --version) already installed (nvm default)"
else
    log "installing Node LTS"
    nvm install --lts
    ok "Node $(node --version) installed"
fi
if npm ls -g tree-sitter-cli &>/dev/null; then
    ok "tree-sitter CLI $(tree-sitter --version 2>/dev/null | awk '{print $2}') already installed"
else
    log "installing tree-sitter CLI"
    npm install -g tree-sitter-cli
    ok "tree-sitter CLI $(tree-sitter --version 2>/dev/null | awk '{print $2}') installed"
fi
set -u

# ---------------------------------------------------------------- 8. neovim (GitHub release)
step "Neovim"
# /opt/nvim/bin is added to PATH in .zshrc. Bump NVIM_VERSION and re-run to upgrade.
NVIM_VERSION=v0.12.4
nvim_current=$(/opt/nvim/bin/nvim --version 2>/dev/null | head -n1 || true)
if [ "$nvim_current" = "NVIM $NVIM_VERSION" ]; then
    ok "$nvim_current already at /opt/nvim"
else
    log "installing neovim $NVIM_VERSION (found: ${nvim_current:-none})"
    $SUDO rm -rf /opt/nvim
    $SUDO mkdir -p /opt/nvim
    curl -fsSL "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-$ARCH_NVIM.tar.gz" \
        | $SUDO tar xzf - -C /opt/nvim --strip-components=1
    ok "$(/opt/nvim/bin/nvim --version | head -n1) installed at /opt/nvim"
fi

# ---------------------------------------------------------------- 9. XDG_RUNTIME_DIR for nvim
step "XDG_RUNTIME_DIR"
# LXC containers don't create /run/user/<uid> (fzf-lua needs it for serverstart).
# /run is tmpfs, so a plain mkdir is lost on reboot; tmpfiles.d recreates it at every boot.
uid=$(id -u); user=$(id -un); group=$(id -gn)
tmpfiles_conf="/etc/tmpfiles.d/run-user-$uid.conf"
tmpfiles_line="d /run/user/$uid 0700 $user $group -"
if [ "$(cat "$tmpfiles_conf" 2>/dev/null)" = "$tmpfiles_line" ]; then
    ok "$tmpfiles_conf already set"
else
    echo "$tmpfiles_line" | $SUDO tee "$tmpfiles_conf" >/dev/null
    ok "wrote $tmpfiles_conf (recreates /run/user/$uid at boot)"
fi
if [ -d "/run/user/$uid" ]; then
    ok "/run/user/$uid exists"
else
    $SUDO install -d -m 0700 -o "$user" -g "$group" "/run/user/$uid"
    ok "created /run/user/$uid"
fi

# ---------------------------------------------------------------- 9b. Neovim plugins
step "Neovim plugins"
# Startup (vim.pack.add in the config) installs missing plugins at the lockfile's revisions;
# update() with target = "lockfile" moves already-installed ones to those revisions too.
# Plugins are updated on the Mac (main branch); containers just follow the lockfile.
mkdir -p "$HOME/.cache"
nvim_log="$HOME/.cache/linux-setup-nvim.log"
log "syncing plugins to $NVIM_LOCK (headless nvim, log: $nvim_log)"
if timeout 900 /opt/nvim/bin/nvim --headless \
        -c 'lua vim.pack.update(nil, { force = true, target = "lockfile" })' \
        -c 'qa!' >"$nvim_log" 2>&1; then
    ok "$(find "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/core/opt" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ') plugins in sync with the lockfile"
else
    warn "headless nvim plugin sync failed (exit $?), last lines of $nvim_log:"$'\n'"$(tail -n 15 "$nvim_log")"
fi
if [ -n "$(git -C "$REPO_DIR" status --porcelain -- "$NVIM_LOCK")" ]; then
    warn "plugin sync changed $NVIM_LOCK (a plugin in the config isn't in the lockfile?):"$'\n'"$(git -C "$REPO_DIR" diff --stat -- "$NVIM_LOCK")"
fi

# ---------------------------------------------------------------- 10. Proxmox prompt info
step "Proxmox prompt"
if [ -n "${CT_ID:-}" ] && [ -n "${PROXMOX_HOST:-}" ]; then
    printf 'export PROXMOX_CT_ID=%s\nexport PROXMOX_HOST=%s\n' "$CT_ID" "$PROXMOX_HOST" \
        | $SUDO tee /etc/profile.d/proxmox-prompt.sh >/dev/null
    ok "wrote /etc/profile.d/proxmox-prompt.sh (CT $CT_ID @ $PROXMOX_HOST)"
else
    ok "skipped (CT_ID / PROXMOX_HOST not set)"
fi

# ---------------------------------------------------------------- summary
step "Summary"
ver() { if command -v "$1" &>/dev/null; then "$@" 2>/dev/null | head -n1; else echo "missing"; fi; }
printf '  %-10s %s\n' \
    zsh     "$(ver zsh --version)" \
    nvim    "$(ver /opt/nvim/bin/nvim --version)" \
    fzf     "$(ver fzf --version)" \
    lazygit "$(command -v lazygit &>/dev/null && lazygit_version || echo missing)" \
    rg      "$(ver rg --version)" \
    fd      "$(ver fd --version)" \
    bat     "$(ver bat --version)" \
    zoxide  "$(ver zoxide --version)" \
    tmux    "$(ver tmux -V)" \
    node    "$(set +u; ver node --version)"

if [ ${#WARNINGS[@]} -gt 0 ]; then
    printf '\n\033[1;33m%d warning(s):\033[0m\n' "${#WARNINGS[@]}"
    printf '  - %s\n' "${WARNINGS[@]}"
fi
printf '\n\033[1;32mSetup finished successfully!\033[0m Log out and back in (or run: exec zsh).\n'
