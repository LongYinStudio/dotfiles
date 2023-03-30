# myConfigFiles
> 自己linux、macos的配置文件(.zshrc、.vimrc等等)

## 备注

1. zsh/oh-my-zsh
   - zsh安装参照网上教程
   
   - zsh/my.zsh-theme是自定义的主题，zsh/.zshrc是配置文件
   
   - 1. 直接下载.zshrc放在~里
     
     2. 安装 `zsh-syntax-highlighting` 和 `zsh-autosuggestions` ：
     
        执行 `git clone https://gitee.com/Annihilater/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting` 安装 `zsh-syntax-highlighting`
     
        执行 `git clone https://gitee.com/phpxxo/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions` 安装 `zsh-autosuggestions` 
     
   - 主题放在\~/.oh-my-zsh/custom/themes或者\~/.oh-my-zsh/themes都行
   
   - <font color=red>export ZSH="/home/longyinstudio/.oh-my-zsh" 记得更换成自己的目录</font>
   
2.  vim
   
   - 下载.vimrc和.vim放在~里，github搜索安装 `vim-plug`
   - onedark主题配置：autoload/onedark.vim放在\~/.vim/autoload里，colors/onedark.vim放在\~/.vim/colors里
   - 插件安装：在.vim里用 `:PlugInstall`
