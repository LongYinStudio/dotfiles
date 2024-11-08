# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

ZSH_DISABLE_COMPFIX="true" # 有的版本有引号， 有的版本无引号，自己尝试
export TERM='xterm-256color'
export ZSH="$HOME/.oh-my-zsh" # oh-my-zsh安装目录

# # 主题(random随机主题(echo $RANDOM_THEME查看随机主题名称)) # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# # 范围随机主题 ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# ZSH_THEME="powerlevel10k/powerlevel10k" # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 编辑器
if command -v nvim &>/dev/null; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi
export HISTSIZE=10000     #历史纪录条目数量
export SAVEHIST=10000     #注销后保存的历史纪录条目数量
setopt INC_APPEND_HISTORY #以附加的方式写入历史纪录
setopt HIST_IGNORE_DUPS   #如果连续输入的命令相同，历史纪录中只保留一个

# 插件配置，zsh-syntax-highlighting和zsh-autosuggestions安装/README.md安装
plugins=(
	git                     # git aliases
	zsh-syntax-highlighting # 命令高亮
	zsh-autosuggestions     # 命令补全
	sudo                    # 双击esc-->sudo
	extract                 # x解压
	universalarchive        # 压缩集合，使用ua+压缩后缀(如:tar.gz、zip等等)+压缩对象
	z                       # z 跳转目录
	tmux                    # tmux aliases
	vi-mode                 # 命令行vim
	command-not-found       # 命令没安装，显示如何安装
)

source "$ZSH"/oh-my-zsh.sh
# export MANPATH="/usr/local/man:$MANPATH" # User configuration

# umask 0077 #修改umask值

# alias 别名 run "alias"可以查看系统，插件，主题等等所有别名
# apt
alias apti="sudo apt install"
alias aptp="sudo apt purge"
alias aptar="sudo apt autoremove"
alias apts="apt search"
# System
alias zshconfig="vim ~/.zshrc"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias q="exit"
alias c="clear"
alias ip="ip -color"
alias o="open ."
if command -v exa &>/dev/null; then
	alias ls="exa --icons"
	alias ll="exa -lah --icons"
	alias lt="exa --tree --long --icons -I 'node_modules|.git'"
fi
[[ $(command -v bat) ]] && alias cat="bat"
# Dev
alias lg="lazygit"
alias p="pnpm"
# Neovim
alias v="nvim"
alias vi="nvim"
alias lv="NVIM_APPNAME=LazyVim nvim"   # git clone https://github.com/LazyVim/starter ~/.config/LazyVim
alias nv="NVIM_APPNAME=NvChad nvim"    # git clone https://github.com/NvChad/starter ~/.config/NvChad
alias av="NVIM_APPNAME=AstroNvim nvim" # git clone --depth 1 https://github.com/AstroNvim/template ~/.config/AstroNvim

# path 环境变量 node 使用的nvm
source "/etc/environment"
source "$HOME/.cargo/env"
bin="$HOME/bin"
go="$HOME/dev-tools/go/bin"
mysql="/usr/local/mysql/bin" # mac dmg安装的mysql
export JAVA_HOME=$HOME/dev-tools/jdk1.8.0_351
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export JRE_HOME=$JAVA_HOME/jre

export PATH="$JAVA_HOME/bin:$bin:$go:$mysql:$PATH"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
# # place this after nvm initialization!
# autoload -U add-zsh-hook
# load-nvmrc() {
# 	local node_version="$(nvm version)"
# 	local nvmrc_path="$(nvm_find_nvmrc)"
# 	if [ -n "$nvmrc_path" ]; then
# 		local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
# 		if [ "$nvmrc_node_version" = "N/A" ]; then
# 			nvm install
# 		elif [ "$nvmrc_node_version" != "$node_version" ]; then
# 			nvm use
# 		fi
# 	elif [ "$node_version" != "$(nvm version default)" ]; then
# 		echo "Reverting to nvm default version"
# 		nvm use default
# 	fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc
# 换用fnm
# curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.fnm" --skip-shell
export FNM_NODE_DIST_MIRROR=https://mirrors.bfsu.edu.cn/nodejs-release/
export PATH="$HOME/.fnm:$PATH"
eval "$(fnm env --use-on-cd)"

# 开启代理函数
PROXY_HTTP="http://127.0.0.1:7890"
function openvpn() {
	export http_proxy="${PROXY_HTTP}"
	export https_proxy="${PROXY_HTTP}"
	export all_proxy=socks5://127.0.0.1:7890
	git config --global http.proxy "${PROXY_HTTP}"
	git config --global https.proxy "${PROXY_HTTP}"
	echo "代理已开"
}

# 关闭代理函数
function closevpn() {
	unset https_proxy
	unset http_proxy
	unset all_proxy
	git config --global --unset http.proxy
	git config --global --unset https.proxy
	echo "代理已关"
}

# TODO: 修改fzf complete
# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # 补全不区分大小写
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'cat'

# FZF
if command -v fzf &>/dev/null; then
	source <(fzf --zsh) # Set up fzf key bindings and fuzzy completion (版本0.54以上)
	alias fv='vim $(fzf)'
	alias fn='nvim $(fzf)'
	alias fp="fzf --preview 'bat --color=always {}'"
	alias fh='history | fzf'
fi

# homebrew
if command -v brew &>/dev/null; then
	export HOMEBREW_INSTALL_FROM_API=1
	export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
	export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
	export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
	export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
fi

# starship 不需要source .zshrc,随便输个命令,就会重新加载配置
[[ $(command -v starship) ]] &&	eval "$(starship init zsh)"
