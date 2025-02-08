#!/bin/bash

if [ -f ~/.vimrc ]; then
	rm -rf ~/.vimrc
	cp ./vimrc ~/.vimrc
fi

if [ -d ~/.vim/ ]; then
	rm -rf ~/.vim
fi

if [ ! -f ~/.vim/autoload/plug.vim ]; then
	echo '==> Installing vim-plug'
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	echo '==> Installing vim plugins'
	vim +PlugInstall +qall
fi
