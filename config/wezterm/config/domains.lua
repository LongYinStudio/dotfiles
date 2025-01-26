return {
   -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
   -- 不使用wezterm的ssh工具
   ssh_domains = {
      {
         multiplexing = 'None',
         name = 'tencent-ubuntu',
         remote_address = 'ip:22',
         username = 'root',
         ssh_option = {
            identityfile = 'C:\\Users\\LongYinStudio\\.ssh\\id_rsa',
         },
      },
   },

   -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
   unix_domains = {},

   -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
   wsl_domains = {
      {
         name = 'WSL:Ubuntu',
         distribution = 'Ubuntu',
         username = 'longyinstudio',
         default_cwd = '/home/longyinstudio',
         default_prog = { 'zsh' },
      },
   },
}
