#!/bin/bash

# Install Oh My Zsh!
if ! [[ -e ~/.oh-my-zsh ]]; then
	git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

if ! [[ -e ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
	git clone https://gitee.com/Annihilater/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
fi

if ! [[ -e ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
	git clone https://gitee.com/phpxxo/zsh-autosuggestions.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
fi

if ! [[ -e ~/.oh-my-zsh/custom/plugins/fzf-tab ]]; then
	git clone https://github.com/Aloxaf/fzf-tab "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/fzf-tab
fi

curl -sS https://starship.rs/install.sh | sh

cp my.zsh-theme ~/.oh-my-zsh/custom/themes
cp zshrc ~/.zshrc

# 前提安装zsh，然后：
# chsh -s /bin/zsh longyinstudio
# chsh -s /bin/zsh root
