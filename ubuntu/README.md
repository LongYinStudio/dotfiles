> ubuntu `别卸载系统软件，不上autoremove时可能系统崩坏`

1. clash: 先下载客户端 [Fndroid/clash-win-docs-new (github.com)](https://github.com/Fndroid/clash-win-docs-new)，再运行（可自行创建clash.desktop，也可以开机自启）；.zshrc或.bashrc添加 （端口根据clash for windows定）

   ```shell 
   export https_proxy=http://127.0.0.1:7890 
   export http_proxy=http://127.0.0.1:7890
   export all_proxy=socks5://127.0.0.1:7890
   ```
   
   运行(两种方式 ) : 
   
   1. 终端执行软件并带上参数 `--proxy-server=http://127.0.0.1:7890` 
   2. 在设置中修改**网络代理**