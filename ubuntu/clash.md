## clash

a. clash 桌面:

1. 先 [Clash Releases](https://www.clash.la/releases/)下载对应的客户端，再运行（可自行创建 clash.desktop，也可以开机自启）

2. 配置代理(四种方式) :

- `最推荐的:` 在设置中修改**网络代理**

- 终端执行软件并带上参数 `--proxy-server=http://127.0.0.1:7890`

- 在.zshrc 或.bashrc 添加 （端口根据 clash for windows 定）,记得 source ,使用后删除三个 export 并再次 source

```shell
export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890
```

- 用 zsh/.zshrc 里定义的 openvpn 和 closevpn 函数(命令)

b. clash 服务器下:

1. 先 [Clash Releases](https://www.clash.la/releases/) 下载对应的压缩包，在解压
2. ```bash
   mv clash-linux-* /usr/local/bin/clash # 移到bin并重命名
   ```
3. ```bash
   chmod +x /usr/local/bin/clash # 添加执行权限
   ```

4. 运行 clash

   - ```bash
     clash	# 这样会直接运行~/.config/clash/config.yaml节点文件
     ```

   - ```bash
     clash -f 节点文件.yaml # 指定节点文件
     ```

5. 配置成服务

   vim /etc/systemd/system/clash.service

   ```bash
   [Unit]
   Description=clash service
   After=network.target

   [Service]
   Type=simple
   User=root
   ExecStart=/usr/local/bin/clash
   Restart=on-failure # or always, on-abort, etc

   [Install]
   WantedBy=multi-user.target
   ```

   设置 clash 开机启动

   ```bash
   systemctl daemon-reload
   systemctl enable clash
   ```

6.配置代理(两种方式)

- 在.zshrc 或.bashrc 添加 （端口根据 clash for windows 定）,记得 source ,使用后删除三个 export 并再次 source

- `最推荐的:` 用 zsh/.zshrc 里定义的 openvpn 和 closevpn 函数(命令)

```shell
export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890
```

1. 可以搭配面板控制

   [haishanh/yacd: Yet Another Clash Dashboard (github.com)](https://github.com/haishanh/yacd)
