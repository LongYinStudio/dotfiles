# dotfiles

> 自己 linux、macos 的配置文件(.zshrc、.vimrc 等等)

![](https://raw.githubusercontent.com/LongYinStudio/dotfiles/main/Screenshots/2025-01-25-145841_hyprshot.png)

## 备注

1. zsh/oh-my-zsh

   - 运行zsh/install.sh
   - 主题

     1. 自制主题(zsh/my.zsh-theme) 改 ZSH_THEME="my"
     2. 推荐主题 [romkatv/powerlevel10k: A Zsh theme (github.com)](https://github.com/romkatv/powerlevel10k)
     3. [starship](https://starship.rs/zh-CN/) 现在在用

   - 最后 `source ~/.zshrc`

2. neovim

   - 包管理器直接可以安装(需要v0.10.0以上)，详细参考官网（[Home - Neovim](https://neovim.io/)）
   - 将 nvim 复制到\~/.config/里
   - 安装依赖，执行install_dep.sh
   - 插件管理: lazy.nvim (:Lazy)

3. tmux
   - 复制 tmux/.tmux.conf 到 ~/
   - 运行：
     1. 执行 tmux 命令(已安装tmux)
     2. - 执行 Ctrl+B :source-file ~/.tmux.conf
        - 或者 直接在tmux的终端里执行 tmux source-file ~/.tmux.conf
