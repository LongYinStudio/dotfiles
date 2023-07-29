vim.g.mapleader = ";"

local keymap = vim.keymap

-- ---------- 插入模式 ---------- ---
keymap.set("i", "jk", "<ESC>")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 切换buffer
keymap.set("n", "<C-L>", ":bnext<CR>")
keymap.set("n", "<C-H>", ":bprevious<CR>")

-- bufferline 左右切换
keymap.set("n", "<leader>h", ":BufferLineCyclePrev<CR>", opt)
keymap.set("n", "<leader>l", ":BufferLineCycleNext<CR>", opt)

-- ---------- 插件 ---------- ---
-- nvim-lspconfig
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, bufopts)                             --定义
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, bufopts)                             --引用
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)                                 --重命名
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)                            --列出code action
vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format { async = true } end, bufopts) --normal下格式
vim.keymap.set("v", "<leader>cf", function() vim.lsp.buf.format { async = true } end, bufopts) --view下格式化
-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
