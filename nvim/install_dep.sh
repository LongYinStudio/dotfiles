#!/bin/bash

# node
npm i -g tree-sitter tree-sitter-cli prettier

# rust
cargo install stylua

# package manager
dependencies=("clang_format" "rustfmt" "shellcheck" "shfmt")

install_with_package_manager() {
	for pkg in "${dependencies[@]}"; do
		if command -v apt-get >/dev/null 2>&1; then
			sudo apt-get install -y "$pkg"
		elif command -v pacman >/dev/null 2>&1; then
			sudo pacman -S --needed --noconfirm "$pkg"
		elif command -v yum >/dev/null 2>&1; then
			sudo yum install -y "$pkg"
		elif command -v dnf >/dev/null 2>&1; then
			sudo dnf install -y "$pkg"
		elif command -v opkg >/dev/null 2>&1; then
			sudo opkg install -y "$pkg"
		elif command -v pkg >/dev/null 2>&1; then
			sudo pkg install -y "$pkg"
		elif command -v brew >/dev/null 2>&1; then
			brew install "$pkg"
		else
			echo "未找到支持的包管理器，无法安装依赖：$pkg"
			exit 1
		fi
	done
}

install_with_package_manager
