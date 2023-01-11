# myConfigFiles
> 自己linux、macos的配置文件(zshrc、vimrc等等)

## 备注

1. oh-my-zsh
   - my.zsh-theme是自定义的主题
   - 直接下载.zshrc放在~里，用系统包管理器(mac--brew  ubuntu--apt)安装 `zsh-syntax-highlighting `和 `zsh-autosuggestions`，并可能需要添加source /路径/*.zsh到.zshrc
   - 主题放在\~/.oh-my-zsh/custom/themes或者\~/.oh-my-zsh/themes都行
2. vim
   - 下载.vimrc放在~里，github搜索安装 `vim-plug`
   - onedark主题配置：autoload/onedark.vim放在\~/.vim/autoload里，colors/onedark.vim放在\~/.vim/colors里
   - 插件安装：在.vim里用 `:PlugInstall`
