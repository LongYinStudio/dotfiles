require("plugins.plugins-setup")

require("core.autocmds")
require("core.options")
require("core.keymaps")

-- 插件
require("plugins.lualine")
require("plugins/nvim-tree")
require("plugins/lsp")
require("plugins/cmp")
require("plugins/comment")
require("plugins/autopairs")
require("plugins/bufferline")
require("plugins/gitsigns")
require("plugins/telescope")
require("plugins/toggleterm")
require("plugins/autotag")
require("plugins/dropbar")
require("plugins/wilder")
require("plugins/colorizer")
require("plugins/conform")

-- 其他
require("others.wsl")
