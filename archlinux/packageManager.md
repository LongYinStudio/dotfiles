# arch 包管理器

## pacman

> sudo pacman -S pacman-contrib

```bash
sudo pacman -S package_name # 安装软件包
pacman -Ss # 在同步数据库中搜索包，包括包的名称和描述
pacman -Si # 显示包信息
pacman -Sl # 列出说有 基本用不到
pacman -Sw # 用来下载某个软件包，但不安装
sudo pacman -Qs package_name # 查找已安装
sudo pacman -Syu # 升级系统。 -y:标记刷新、-yy：标记强制刷新、-u：标记升级动作（一般使用 -Syu 即可）
sudo pacman -Syu --ignore=vlc # --ignore指定系统更新时，忽略某个软件包。
sudo pacman -R package_name # 删除软件包，保留其全部已经安装的依赖关系
sudo pacman -Rs package_name # 删除，删除没用依赖
sudo pacman -Rns package_name # 删除软件包，及其所有没有被其他已安装软件包使用的依赖包
pacman -Qi package_name # 检查已安装包的相关信息。-Q：查询本地软件包数据库
pacman -Ql package_name # 用来查看某个软件包安装的所有文件
pacman -Qm package_name # 检查手动安装的包（大多是aur的）
pacman -Qu package_name # 检查可升级的
pacman -Qo /usr/bin/vlc # 用来查看某个可执行文件属于哪个软件包
pacman -Qdt # 找出孤立包。-d：标记依赖包、-t：标记不需要的包、-dt：合并标记孤立包
sudo pacman -Rns $(pacman -Qtdq) # 删除孤立包
sudo pacman -Fy # 更新命令查询文件列表数据库
pacman -F some_command # 当不知道某个命令属于哪个包时，用来在远程软件包中查询某个命令属于哪个包（即使没有安装）
pactree package_name # 查看一个包的依赖树
sudo pacman -Sc # 删除当前未安装的所有缓存包和未使用的同步数据库（可选）
sudo pacman -Scc # 从缓存中删除所有文件，这是最激进的方法，不会在缓存文件夹中留下任何内容（一般不使用）
paccache -r # 删除已安装和未安装包的所有缓存版本，但最近 3 个版本除外
sudo paccache -rk 1 # 只保留最新的一个版本
sudo paccache -ruk 0 # 删除已卸载的所有缓存版本 等效于 pacman -Sc
```

> archlinuxcn源

1. 在`/etc/pacman.conf`尾部添加archlinuxcn源

```bash
[archlinuxcn]
# SigLevel = Optional TrustAll # 可选
Server = http://mirrors.ustc.edu.cn/archlinux/$arch
Server = http://mirrors.163.com/archlinux-cn/$arch
```

2. 导入 GPG key, 并安装pacman-contrib和yay/paru

```bash
sudo pacman-key --lsign-key "farseerfc@archlinux.org"
sudo pacman -Syy --noconfirm
sudo pacman -Fyy --noconfirm
sudo pacman -S --needed --noconfirm pacman-contrib
sudo pacman -S --needed --noconfirm archlinuxcn-keyring archlinux-keyring
sudo pacman -S --needed --noconfirm yay paru
```

> 配置pacman

```bash
sudo sed -i.bak 's/^#Color/Color/' /etc/pacman.conf
sudo sed -i.bak "s/^#ParallelDownloads .*/ParallelDownloads = 40/" /etc/pacman.conf
sudo sed -i.bak 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
# sudo sed -i.bak "s/^#\[multilib\]/\[multilib\]/" /etc/pacman.conf #32位应用
# sudo sed -i.bak '/\[multilib\]/ {n;s/^#//;}' /etc/pacman.conf
```

## yay

> yay 的用法和 Pacman 是基本一样的。有额外几条常用命令：

```bash
yay # 等同于 yay -Syu
yay package_name # 等同于 yay -Ss package_name && yay -S package_name
yay -Ps # 打印系统统计信息
yay -Yc # 清理不需要的依赖
rm -rf ~/.cache/yay # 清理 yay 缓存
```

> 另外，不用官网的编译安装，archlinuxcn里就有yay

## downgrade

> 在 archlinux 上安装旧版软件都通过 downgrade 来进行管理。

```bash
yay -S downgrade
```

## Octopi

> 此外，还可以使用图形化的包管理软件（Pacman / yay 的图形前端）Octopi。

```bash
   yay -S octopi
```
