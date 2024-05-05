# dotfiles

> 自己 linux、macos 的配置文件(.zshrc、.vimrc 等等)

## 备注

1. zsh/oh-my-zsh
   
   - zsh 和 oh-my-zsh 安装参照网上教程
   
   - 复制 zsh/.zshrc 到 ~/
   
   - 安装 `zsh-syntax-highlighting` 和 `zsh-autosuggestions` ：
     
     执行 `git clone https://gitee.com/Annihilater/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting` 安装 `zsh-syntax-highlighting`
     
     执行 `git clone https://gitee.com/phpxxo/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions` 安装 `zsh-autosuggestions`
   
   - 主题
     
     1. 自制主题(zsh/my.zsh-theme)放在\~/.oh-my-zsh/custom/themes 或者\~/.oh-my-zsh/themes 都行
     2. 推荐主题 [romkatv/powerlevel10k: A Zsh theme (github.com)](https://github.com/romkatv/powerlevel10k)
   
   - 最后 `source ~/.zshrc`

2. vim
   
   - 下载.vimrc 和.vim 放在~里，github 搜索安装 `vim-plug`
   
   - onedark 主题配置：autoload/onedark.vim 放在\~/.vim/autoload 里，colors/onedark.vim 放在\~/.vim/colors 里
   
   - 插件安装：在.vim 里用 `:PlugInstall`

3. neovim
   
   - 安装 apt / brew / scoop 等等包管理器直接可以安装，详细参考官网（[Home - Neovim](https://neovim.io/)）
   - 将 nvim 复制到\~/.config/里
   - 插件安装:
     1. neovim \~/.config/nvim/lua/plugins/plugins-setup.lua
     2. normal 模式下:w 就可以自动安装配置的插件 || :Lazy 呼出 Lazy 管理界面
   
   - 安装\~/.config/nvim/lua/plugins/conform.lua 里用到的 formatters
4. tmux
   - 用包管理器安装tmux
   - 复制 tmux/.tmux.conf 到 ~/

1. [ubuntu (ubuntu/README.md)](ubuntu/README.md)
   
   - [clash 配置 (ubuntu/clash.md)](ubuntu/clash.md)

2. [wezterm (wezterm/README.md)](wezterm/README.md)
