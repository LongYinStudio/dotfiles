local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true

-- 缩进
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wildmenu = true -- 补全增强
opt.modifiable = true -- 设置'modifiable'选项为true
opt.cursorline = true -- 光标行
opt.mouse:append("a") -- 启用鼠标
opt.clipboard:append("unnamedplus") -- 系统剪贴板
-- opt.undofile = true --持久化撤销

-- 自动换行
opt.wrap = false
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md, *.txt", command = "setlocal wrap" })

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 折叠
vim.opt.foldmethod = "manual"

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"
vim.cmd([[colorscheme onedark]])
