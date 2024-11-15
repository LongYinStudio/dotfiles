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
$pacMan mycli # litecli mssql-cli iredis pgcli
#       ip计算 计算器
$pacMan ipcalc bc # qalculate
# 同步备份
$pacMan rsync rclone # rclone-browser
# 各种查看系统信息的软件
$pacMan btop htop cpufetch        # plasma-systemmonitor
$pacMan zsh ffmpeg tree tmux tldr # kdeconnect
# exa 可以换成 eza
$pacMan figlet net-tools ripgrep fzf jq bat exa curl git wget vim \
	neofetch onefetch trash-cli imagemagick transmission-cli
#       文件转换
$pacMan pandoc
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# ~/.fzf/install
# https://github.com/iawia002/lux?tab=readme-ov-file#installation
# https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
# https://yazi-rs.github.io/docs/installation/

if command -v apt-get >/dev/null 2>&1; then
	sudo apt-get install -y fd-find network-manager traceroute sqlite3 # kitty
	# ubuntu 需要手动安装最新的neovim
elif command -v pacman >/dev/null 2>&1; then
	sudo pacman -S --needed fd networkmanager traceroute neovim sqlite # ttf-nerd-fonts-symbols-mono kitty wezterm
elif command -v brew >/dev/null 2>&1; then
	brew install fd neovim sqlite
	# brew install --cask kitty wezterm
fi
