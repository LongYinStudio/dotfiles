# dotfiles

> 自己 linux、macos 的配置文件(.zshrc、.vimrc 等等)

## 备注

1. zsh/oh-my-zsh

   - zsh 和 oh-my-zsh 安装参照网上教程

   - 复制 zsh/.zshrc 和 zsh/.my-zsh 到 ~/

   - 安装 `zsh-syntax-highlighting` 和 `zsh-autosuggestions` ：

     执行 `git clone https://gitee.com/Annihilater/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting` 安装 `zsh-syntax-highlighting`

     执行 `git clone https://gitee.com/phpxxo/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions` 安装 `zsh-autosuggestions`

   - 主题

     1. 自制主题(zsh/my.zsh-theme)放在\~/.oh-my-zsh/custom/themes 或者\~/.oh-my-zsh/themes 都行
     2. 推荐主题 [romkatv/powerlevel10k: A Zsh theme (github.com)](https://github.com/romkatv/powerlevel10k)

   - <font color=red>export ZSH="/home/longyinstudio/.oh-my-zsh" 记得更换成自己的目录</font>

   - 最后 `source ~/.zshrc`

2. vim

   - 下载.vimrc 和.vim 放在~里，github 搜索安装 `vim-plug`

   - onedark 主题配置：autoload/onedark.vim 放在\~/.vim/autoload 里，colors/onedark.vim 放在\~/.vim/colors 里

   - 插件安装：在.vim 里用 `:PlugInstall`


3. neovim

   > 现已使用Lazy.nvim来管理neovim插件，就可以删除 \~/.config/nvim/plugin/packer_compiled.lua
   >
   > 当然也可继续用packer

   - 安装 apt / brew / scoop等等包管理器直接可以安装，详细参考官网（[Home - Neovim](https://neovim.io/)）
   - 将 nvim 复制到\~/.config/里
   - neovim \~/.config/nvim/lua/plugins/plugins-setup.lua
   - 插件安装: 

     1. Lazy：normal模式下:w就可以自动安装配置的插件 || :Lazy呼出Lazy管理界面
     1. packer：删除plugins-setup.lua，将plugins-setup.backup.lua重命名为plugins-setup.lua，normal模式下:w就可以自动安装配置的插件

4. [ubuntu (ubuntu/README.md)](ubuntu/README.md)

   - [clash配置 (ubuntu/clash.md)](ubuntu/clash.md)
