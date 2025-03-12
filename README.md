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

   - 复制 tmux.conf 到 ~/.tmux.conf
   - 运行：
     1. 执行 tmux 命令(已安装tmux)
     2. - 执行 Ctrl+B :source-file ~/.tmux.conf
        - 或者 直接在tmux的终端里执行 tmux source-file ~/.tmux.conf

4. config/\* 直接复制到~/.config/, 里面大多不需要额外配置, 安装软件就好

5. kde 推荐配置
   将`置顶`快捷键设置为`Meta(Win)+C`
   将`显示/隐藏窗口标题栏和框架`快捷键设为`Meta(Win)+M`

6. `~/config/microsoft-edge-stable-flags.conf`:

   > 解决切换kde到hypr，edge丢失网站登陆状态 https://wiki.archlinux.org/title/KDE_Wallet#KDE_Wallet_for_Chrome_and_Chromium

   > 如果是gnome用gnome-libsecret，还可以是第三方的，等等
