# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_DISABLE_COMPFIX="true"    # 有的版本有引号， 有的版本无引号，自己尝试
export TERM='xterm-256color'
# export PATH=$HOME/bin:/usr/local/bin:$PATH # 从bash过来，可能需要修改$PATH

export ZSH="/home/longyinstudio/.oh-my-zsh" #oh-my-zsh安装目录

# 主题(random随机主题(echo $RANDOM_THEME查看随机主题名称))
# 范围随机主题 ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export EDITOR=vim #编辑器
export HISTSIZE=10000 #历史纪录条目数量
export SAVEHIST=10000 #注销后保存的历史纪录条目数量
setopt INC_APPEND_HISTORY #以附加的方式写入历史纪录
setopt HIST_IGNORE_DUPS #如果连续输入的命令相同，历史纪录中只保留一个

# 插件配置，zsh-syntax-highlighting和zsh-autosuggestions安装/README.md安装
plugins=(
    git # git aliases
    zsh-syntax-highlighting # 命令高亮
    zsh-autosuggestions # 命令补全
    sudo # 双击esc-->sudo
    extract # x解压
    universalarchive # 压缩集合，使用ua+压缩后缀(如:tar.gz、zip等等)+压缩对象
    z # z 跳转目录
    tmux # tmux aliases
    vi-mode # 命令行vim
    command-not-found # 命令没安装，显示如何安装
)

source $ZSH/oh-my-zsh.sh
# export MANPATH="/usr/local/man:$MANPATH" # User configuration

# umask 0077 #修改umask值

# alias 别名 run "alias"可以查看系统，插件，主题等等所有别名
alias zshconfig="vim ~/.zshrc"
# cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
# apt
alias apti="sudo apt install"
alias aptp="sudo apt purge"
alias aptar="sudo apt autoremove"
alias apts="apt search"

# path 环境变量 node 使用的nvm
bin="/home/longyinstudio/bin"
go="/home/longyinstudio/dev-tools/go/bin"
mysql="/usr/local/mysql/bin" # mac dmg安装的mysql
export JAVA_HOME=/home/longyinstudio/dev-tools/jdk1.8.0_351
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export JRE_HOME=$JAVA_HOME/jre 

export PATH="$JAVA_HOME/bin:$bin:$go:$mysql:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# 开启代理函数
function openvpn() {
    export https_proxy=http://127.0.0.1:7890
    export http_proxy=http://127.0.0.1:7890
    export all_proxy=socks5://127.0.0.1:7890
    echo "代理已开"
}

# 关闭代理函数
function closevpn() {
    unset https_proxy
    unset http_proxy
    unset all_proxy
    echo "代理已关"
}