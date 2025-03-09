#!/bin/bash

# node
npm i -g neovim tree-sitter tree-sitter-cli prettier stylelint markmap-cli

# rust
cargo install stylua
rustup component add rustfmt

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

$pacMan luarocks shellcheck shfmt ripgrep

# neovim 现在需要lua5.1
if command -v apt-get >/dev/null 2>&1; then
	sudo apt-get install -y lua5.1 fd-find clang-format python3-neovim
elif command -v pacman >/dev/null 2>&1; then
	# clang包含clang-format
	sudo pacman -S --needed lua51 fd clang python-neovim
elif command -v brew >/dev/null 2>&1; then
	brew install lua@5.1 fd clang-format
	pip3 install neovim --upgrade # 或者brew install neovim-remote
fi

# 移除nvim配置
# rm -rf ~/.config/nvim && rm -rf ~/.local/share/nvim && rm -rf ~/.local/state/nvim && rm -rf ~/.cache/nvim
