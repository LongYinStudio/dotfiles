#!/bin/bash

# package manager (yum dnf opkg pkg 很少用了，自行添加)
get_package_manager() {
  if command -v apt-get >/dev/null 2>&1; then
    echo "sudo apt-get install -y"
  elif command -v pacman >/dev/null 2>&1; then
    echo "sudo pacman -S --needed --noconfirm"
  elif command -v brew >/dev/null 2>&1; then
    echo "brew install"
  else
    echo 'Can not use.'
    exit 0
  fi
}

pacMan=$(get_package_manager)

#       mysql, sqlite, mysql, redis, postgres
$pacMan mycli # litecli mssql-cli iredis pgcli # rainfrog
#       ip计算 计算器 https://github.com/alt-romes/programmer-calculator
$pacMan ipcalc bc # qalculate
# 同步备份
$pacMan rsync rclone # rclone-browser
# 各种查看系统信息的软件
$pacMan btop htop cpufetch duf gdu # glances plasma-systemmonitor hardinfo2 sysmontask mission-center cpu-x
$pacMan zsh ffmpeg tree tmux tldr  # kdeconnect
$pacMan figlet net-tools ripgrep fzf jq bat exa curl git wget vim \
  neofetch onefetch trash-cli imagemagick transmission-cli \
  unzip unrar p7zip gping
#       文件转换 翻译
$pacMan pandoc translate-shell
# 容器 podman-desktop pods
# $pacMan docker podman lazydocker

if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get install -y fd-find network-manager traceroute sqlite3 # kitty
  # ubuntu 需要手动安装 neovim(包旧) lux
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed fd networkmanager traceroute neovim sqlite lux-dl inetutils # ttf-nerd-fonts-symbols-mono kitty wezterm
elif command -v brew >/dev/null 2>&1; then
  # mac 内置traceroute
  brew install fd neovim sqlite lux inetutils
  # brew install --cask kitty wezterm
fi

[ -d "$HOME/.fzf" ] || (git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME"/.fzf && "$HOME"/.fzf/install)
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
[ -x "$(command -v cargo)" ] || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup install stable
[ -x "$(command -v zoxide)" ] || cargo install zoxide
[ -x "$(command -v rg)" ] || cargo install ripgrep
[ -x "$(command -v eza)" ] || cargo install eza # 使用eza替代exa，因为eza基于rust且更新频繁
[ -x "$(command -v fd)" ] || cargo install fd-find
[ -x "$(command -v dust)" ] || cargo install du-dust
[ -x "$(command -v mdcat)" ] || cargo install mdcat
[ -x "$(command -v git-delta)" ] || cargo install git-delta
# [ -x "$(command -v yazi)" ] || cargo install --locked yazi-fm yazi-cli
# [ -x "$(command -v starship)" ] || curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir $HOME/.local/bin
