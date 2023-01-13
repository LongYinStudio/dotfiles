ZSH_DISABLE_COMPFIX="true"    # 有的版本有引号， 有的版本无引号，自己尝试
export TERM='xterm-256color'
# export PATH=$HOME/bin:/usr/local/bin:$PATH # 从bash过来，可能需要修改$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/longyinstudio/.oh-my-zsh"

# 主题(random随机主题(echo $RANDOM_THEME查看随机主题名称))
# 范围随机主题 ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="my"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# zstyle ':omz:update' frequency 13 #自动更新频率(天)
# zstyle ':omz:update' mode disabled  # 禁用自动更新
# zstyle ':omz:update' mode auto      # 自动更新，无需询问
# zstyle ':omz:update' mode reminder  # 提醒更新

# 区分大小写的补全 CASE_SENSITIVE="true"
# DISABLE_LS_COLORS="true" #禁用ls中的颜色
# DISABLE_AUTO_TITLE="true" #禁用自动设置终端标题
# ENABLE_CORRECTION="true" #启用目录自动更正
# export LANG=en_US.UTF-8 # 语言环境
# export ARCHFLAGS="-arch x86_64" # 编译标志(Compilation flags)
# HIST_STAMPS="yyyy-mm-dd" # history -n 的时间样式，"mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# ZSH_CUSTOM=/path/to/new-custom-folder # 配置除$ZSH/custom以外的自定义目录
# DISABLE_MAGIC_FUNCTIONS="true" # 粘贴URLs、text等出错时，取消下一行注释

export EDITOR=vim #编辑器
export HISTSIZE=10000 #历史纪录条目数量
export SAVEHIST=10000 #注销后保存的历史纪录条目数量
setopt INC_APPEND_HISTORY #以附加的方式写入历史纪录
setopt HIST_IGNORE_DUPS #如果连续输入的命令相同，历史纪录中只保留一个


# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# 插件配置，zsh-syntax-highlighting和zsh-autosuggestions需要用包管理器安装
plugins=(git zsh-syntax-highlighting zsh-autosuggestions sudo extract z themes tmux)
# mac可能需要source一下(zsh-syntax-highlighting和zsh-autosuggestions)
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source $ZSH/oh-my-zsh.sh
# export MANPATH="/usr/local/man:$MANPATH" # User configuration

# 本地和远程会话的首选编辑器
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
#if [[ -n $SSH_CONNECTION ]]; then
#  echo "ssh登录"
#else
#  echo "本地登录"
#fi

# 设置别名(可以覆盖其他的)，run "alias"可以查看系统，插件，主题等等所有别名
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
