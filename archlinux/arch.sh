#!/bin/bash

# 先安装[intel|amd]-ucode，配置pacman等等，再运行tools_install.sh
get_package_manager() {
  if [[ $(grep -c arch /etc/os-release) != 0 ]]; then
    echo "sudo pacman -S --needed --noconfirm"
  else
    echo 'Can not use.'
    exit 0
  fi
}
pacMan=$(get_package_manager)
aurPkg='yay -S --needed --noconfirm'

# 字体
$pacMan adobe-source-han-serif-cn-fonts adobe-source-han-sans-cn-fonts \
  noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
  ttf-nerd-fonts-symbols-mono ttf-jetbrains-mono-nerd
# nerd-fonts-complete otf-font-awesome ttf-maplemono-nf-cn ttf-fira-code ttf-firacode-nerd

fc-cache -fv

# 终端
$pacMan kitty wezterm alacritty

# 输入法 fcitx5-im(fcitx5、fcitx5-configtool、fcitx5-gtk、fcitx5-qt)
$pacMan fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-zhwiki fcitx5-pinyin-moegirl fcitx5-table-extra fcitx5-table-other
$aurPkg fcitx5-pinyin-custom-pinyin-dictionary # catppuccin-fcitx5-git fcitx5-mellow-themes-git

# 浏览器
$aurPkg microsoft-edge-stable-bin google-chrome firefox # zen-browser-bin zen-browser-i18n-zh-cn
xdg-settings set default-web-browser microsoft-edge-stable.desktop

# 图片、视频、音乐相关 flameshot在hyprland下无法使用，安装flameshot-git(aur), haruna是kde旗下的一个播放器
$pacMan gwenview imagemagick gimp mpv vlc obs-studio kdenlive cava haruna # celluloid krita blender # blender不仅可3D,还可编辑图片/视频
# $aurPkg spotify netease-cloud-music qqmusic-bin listen1 snipaste

# (ntfs，压缩, 备份, 显示快捷键, 视频缩略图-文件管理器里, 3写盘, 空间扫描, adb投屏, 硬盘测速
# (写盘, 远程, 网盘, 下载, 有道云笔记, anki, utools, 传文件, 两腾讯云cos, picgo, drawio可以用PWA) todesk需要启动服务 escrcpy(scrcpy electron)
$pacMan ntfs-3g ark timeshift screenkey ffmpegthumbnailer isoimagewriter deepin-boot-maker ventoy filelight scrcpy # kdiskmark
# $aurPkg balena-etcher todesk-bin baidunetdisk-bin motrix-bin # ynote-desktop-bin anki utools localsend-bin cosfs cosbrowser picgo drawio-desktop-bin archlinux-tweak-tool-git

# 划词翻译(archlinuxcn源,或者aur)), tesseract qt前端 (目前用utools)
# $pacMan pot-translation tesseract-data-chi_sim tesseract-data-eng gimagereader-qt # translate-shell

# 其他kde应用(系统日志, kde计算器(或qalculate), 颜色拾取, git, 磁盘分区, 下载, 集成开发环境, 阅读器)
$pacMan ksystemlog kcalc kcolorchooser kommit # partitionmanager ktorrent kdevelop okular

# i3wm (rofi需要自行编译支持中文，polkit-gnome显示效果更好些)  # polkit-kde-agent
$pacMan i3-wm i3status polybar lxappearance polkit polkit-qt5 polkit-gnome \
  xclip copyq feh dunst picom dolphin networkmanager network-manager-applet

# hyprland 最好i3和hypr一起安装，有些重复的依赖就没多写一便 paper-icon-theme-git已归档换成papirus-icon-theme(dunst需要) wlr-randr,xrandr-wlr-randr,xprop-wdisplays是显示器配置
$aurPkg hyprland waybar wofi wlogout hyprlock hyprpicker xdg-desktop-portal-hyprland pipewire wireplumber \
  xdg-desktop-portal swayosd brightnessctl hypridle wlsunset hyprpaper hyprshot cliphist safeeyes \
  wl-clipboard qt5-wayland qt6-wayland playerctl jq flameshot-git paper-icon-theme-git hyprprop-git wlr-randr # xrandr-wlr-randr,xprop-wdisplays gnome-calendar pipes.sh

# dev 最好用toolbox，这样arch滚的时候不用更新jet的IDE(包括Android Studio)，太大费流量
$aurPkg visual-studio-code-bin navicat-premium-lite-cs jetbrains-toolbox android-tools \
  reqable-bin xmind typora zeal-git # rofi-zeal-git tabby wechat-devtools-bin archbuilder-git github-desktop-bin httpie pods nmap
# $pacMan mariadb # MariaDB由MySQL的一些原始开发者创建，目的是确保MySQL在被Oracle收购后仍然保持开源。
# sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
# sudo systemctl enable mariadb.service
# sudo systemctl start mariadb.service
# sudo mysql
# set password for root@localhost = password('新密码'); # exit;

# 社交等等 (wechat bwrap需要在~/.config/wechat-universal/binds.list里添加目录才可以传文件，包括拖拽)
# $aurPkg linuxqq wechat-universal-bwrap wemeet-bin # wemeet-bwrap wemeet-wayland-screenshare-git feishu-bin

# wps
# $aurPkg wps-office-cn ttf-wps-fonts wps-office-mui-zh-cn ttf-ms-fonts libtiff5 wps-office-fonts ttf-ms-win11-auto-zh_cn freetype2-wps # wps-office

# gpu (常用的是intel_gpu_top和intel_gpu_time, 需要sudo)
# $pacMan intel-gpu-tools # radeontop
# nvtop对intel gpu的支持还不够好
# git clone https://github.com/Syllo/nvtop.git
# cd nvtop && mkdir build && cd build
# cmake -DINTEL_SUPPORT=ON ..
# make
# sudo make install

# 打印 cups和cups-browsed需要启动服务
# $pacMan cups cups-pdf system-config-printer cups-filters # cups-browsed bluez-cups nss-mdns gutenprint

# 续航 (smartmontools针对有机械硬盘的, tp_smapi[-lts]是Thinkpad电池校准和充电阈值, acpi_call[-lts]和tp_smapi类似但不特指Thinkpad)
# 推荐配置:用电池下节能模式以及频率，禁用LAN唤醒（默认就是禁用的，LAN唤醒会让电脑在关机状态下电量越来越少）
# $pacMan tlp tlp-rdw x86_energy_perf_policy ethtool # smartmontools tp_smapi acpi_call
# $aurPkg tlpui
# sudo systemctl start tlp.service NetworkManager-dispatcher.service
# sudo systemctl enable tlp.service NetworkManager-dispatcher.service
# sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket # 屏蔽服务以避免冲突，确保 TLP 无线设备的开关选项可以正确运行

# virtualbox、vmware、kvm 先安装 linux-headers 并重启 virtualbox需要关闭kvm
# $pacMan virtualbox virtualbox-guest-iso # 默认内核选virtualbox-host-modules-arch, 其他virtualbox-host-dkms virtualbox-host-modules-lts
# sudo modprobe vboxdrv vboxnetadp vboxnetflt # 加载virtualbox内核模块 驱动、桥接、host-only、pci
# yay -S virtualbox-ext-oracle
# sudo gpasswd -a "$USER" vboxusers
# newgrp vboxusers
# KVM 虚拟机内系统要安装一些工具(主要spice-guest-tools,spice-webdavd)主要是windows安装,linux用包管理器安装这些就好:https://www.spice-space.org/download/windows/，或者virtio-vim但是太大了
# $pacMan virtio-win  # 驱动包位于 /var/lib/libvirt/images/virtio-win.iso，如果找不到，用pacman -Ql virtio-win 查看
$pacMan qemu libvirt virt-manager virt-viewer virt-install edk2-ovmf bridge-utils # qemu-full dnsmasq # 最好不安装dnsmasq,弄懂了再用它
# sudo usermod -aG kvm,libvirt $USER
# newgrp libvirt  # 立即生效（或重新登录）
# $pacMan gnome-boxes # 开箱即用

# 蓝牙
# sudo systemctl start --now bluetooth # 若有,看情况enable(开机自启)
# $aurPkg bluez bluez-utils blueman

# 解决mimeapps.list不起作用
# Install archlinux-xdg-menu and run `XDG_MENU_PREFIX=arch- kbuildsycoca6` or add `export XDG_MENU_PREFIX=plasma-` to .xinitrc.
# 已在hypr/lib/env.conf里添加`env = XDG_MENU_PREFIX,arch-`
# $pacMan archlinux-xdg-menu

# game (steam包需要开multilib,即32位) 主要使用steam的proton兼容层
# $pacMan steam lutris

$pacMan man-db man-pages man-pages-zh_cn

# deb安装
# $aurPkg debtap
# sudo sed -i "s|http://ftp.debian.org/debian/dists|https://mirrors.ustc.edu.cn/debian/dists|g" /usr/bin/debtap
# sudo sed -i "s|http://archive.ubuntu.com/ubuntu/dists|https://mirrors.ustc.edu.cn/ubuntu/dists|g" /usr/bin/debtap
