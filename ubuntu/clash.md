## clash

a. clash桌面: 

1. 先 [Fndroid/clash_for_windows_pkg: A Windows/macOS GUI based on Clash (github.com)](https://github.com/Fndroid/clash_for_windows_pkg) release下载对应的客户端，再运行（可自行创建clash.desktop，也可以开机自启）；.zshrc或.bashrc添加 （端口根据clash for windows定）,记得source

```shell 
export https_proxy=http://127.0.0.1:7890 
export http_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890
```

2. 运行(两种方式 ) : 

   - 终端执行软件并带上参数 `--proxy-server=http://127.0.0.1:7890` 

   - 在设置中修改**网络代理**

b. clash 服务器下:

1. 先 [Dreamacro/clash: A rule-based tunnel in Go. (github.com)](https://github.com/Dreamacro/clash) release下载对应的压缩包，在解压
2. ```bash
	mv clash-linux-* /usr/local/bin/clash # 移到bin并重命名
	```
3. ```bash
	chmod +x /usr/local/bin/clash # 添加执行权限
	```
4. .zshrc或.bashrc添加 （端口根据clash定）,记得source


```shell 
export https_proxy=http://127.0.0.1:7890 
export http_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890
```

5. 运行clash

   - ```bash
     clash	# 这样会直接运行~/.config/clash/config.yaml节点文件
     ```


      - ```bash
        clash -f 节点文件.yaml # 指定节点文件
        ```

6. 配置成服务

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

   设置clash开机启动

   ```bash
   systemctl daemon-reload
   systemctl enable clash
   ```

7. 可以搭配面板控制

   [haishanh/yacd: Yet Another Clash Dashboard (github.com)](https://github.com/haishanh/yacd)