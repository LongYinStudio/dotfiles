# 一些未分类的

1. `sudo -E, --preserve-env # 在执行命令时保留用户环境` 通常用于nvim/vim `sudo -E nvim`
2. archlinuxcn 里有 clash-verge-rev 和 yay
3. 浏览器vim插件推荐`Vimium-C`而不是`Vimium`，默认配置就好
4. `playerctl --all-players play-pause` 一键切换所有暂停/播放
5. wechat-universal-bwrap现在无法在wayland运行，安装xwayland-satellite并运行它后，就可以了
6. 打印机数据库:
   foomatic-db
   foomatic-db-engine
   foomatic-db-gutenprint-ppds
   foomatic-db-nonfree
   foomatic-db-nonfree-ppds
   foomatic-db-ppds
7. JetBrainsMonoNLNerdFont-Regular.ttf和JetBrainsMonoNerdFont-Regular.ttf区别：
   名字中的"NL"是"No Ligatures"，即不包含连字（连字：两个或多个字符组成一个特殊字符的设计，例如:两个等号==会被渲染成一个长等号）
8. 解决SDDM里触摸板无法单击切换DE/WM，修改`/etc/X11/xorg.conf.d/20-touchpad.conf`，内容:

```ini
Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"

        Option "Tapping" "on"
        Option "NaturalScrolling" "on"
        Option "MiddleEmulation" "on"
        Option "DisableWhileTyping" "on"
EndSection
```

9. kde 6.4 将wayland和x11分离了，默认wayland，x11需要单独装`plasma-x11-session`
