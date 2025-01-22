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
# nerd-fonts-complete
fc-cache -fv

# 终端
$pacMan kitty wezterm alacritty

# 输入法 fcitx5-im(fcitx5、fcitx5-configtool、fcitx5-gtk、fcitx5-qt)
$pacMan fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-zhwiki fcitx5-pinyin-moegirl fcitx5-table-extra fcitx5-table-other
$aurPkg fcitx5-pinyin-custom-pinyin-dictionary # catppuccin-fcitx5-git fcitx5-mellow-themes-git

# 浏览器
$aurPkg microsoft-edge-stable-bin google-chrome firefox
xdg-settings set default-web-browser microsoft-edge-stable.desktop

# 图片、视频、音乐相关
$pacMan gwenview flameshot imagemagick gimp mpv vlc obs-studio kdenlive cava
# $aurPkg spotify netease-cloud-music qqmusic-bin

# 其他工具 (ntfs支持，压缩, 备份, 显示快捷键, 视频缩略图-文件管理器里, 2写盘, kde计算器(qalculate也不错))
# (写盘, 远程, 下载, 有道云笔记, anki, utools, 传文件, 两腾讯云cos, picgo)
$pacMan ntfs-3g ark timeshift screenkey ffmpegthumbnailer deepin-boot-maker ventoy kcalc
# $aurPkg balena-etcher todesk-bin baidunetdisk-bin motrix-bin drawio-desktop-bin # ynote-desktop-bin anki utools localsend-bin cosfs cosbrowser picgo

# i3wm (rofi需要自行编译支持中文，polkit-gnome显示效果更好些)  # polkit-kde-agent
$pacMan i3-wm i3status polybar lxappearance polkit polkit-qt5 polkit-gnome \
	xclip copyq feh dunst picom dolphin networkmanager network-manager-applet

# hyprland

# dev 最好用toolbox，这样arch滚的时候不用更新jet的IDE(包括Android Studio)，太大费流量
$aurPkg visual-studio-code-bin navicat-premium-lite-cs jetbrains-toolbox android-tools \
	reqable-bin xmind typora zeal-git # rofi-zeal-git tabby wechat-devtools-bin archbuilder-git
# $pacMan mariadb # MariaDB由MySQL的一些原始开发者创建，目的是确保MySQL在被Oracle收购后仍然保持开源。
# sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
# sudo systemctl enable mariadb.service
# sudo systemctl start mariadb.service
# sudo mysql
# set password for root@localhost = password('新密码'); # exit;

# 社交等等
# $aurPkg linuxqq wechat-universal-bwrap wemeet-bin # wemeet-bwrap wemeet-wayland-screenshare-git feishu-bin

# wps
# $aurPkg wps-office-cn ttf-wps-fonts wps-office-mui-zh-cn ttf-ms-fonts libtiff5 wps-office-fonts ttf-ms-win11-auto-zh_cn freetype2-wps # wps-office

# gpu (常用的是intel_gpu_top和intel_gpu_time, 需要sudo)
# $pacMan intel-gpu-tools

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
# $pacMan virt-manager virt-viewer virt-install qemu libvirt edk2-ovmf # KVM
$pacMan gnome-boxes # 开箱即用

# game (steam包需要开multilib,即32位)
# $pacMan steam lutris
