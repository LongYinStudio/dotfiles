vim.g.mapleader = ";"

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

-- 配置删除(d)不复制
keymap({ "n", "v" }, "d", '"_d')

-- ---------- 插入模式 ---------- ---
keymap("i", "jk", "<ESC>")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
-- H一行开始 L一行结束
keymap("v", "H", "0", opts)
keymap("v", "L", "$", opts)

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap("n", "<leader>sv", "<C-w>v") -- 水平新增窗口
keymap("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)
-- 取消高亮
keymap("n", "<leader>nh", ":nohl<CR>")

-- ---------- 插件 ---------- ---
-- nvim-lspconfig
keymap("n", "<leader>gd", vim.lsp.buf.definition, opts) --定义
keymap("n", "<leader>gr", vim.lsp.buf.references, opts) --引用
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts) --重命名
keymap("n", "<F2>", vim.lsp.buf.rename, opts) --重命名
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts) --列出code action
-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>")
-- bufferline 左右切换
keymap("n", "<leader>h", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<leader>l", ":BufferLineCycleNext<CR>", opts)
-- keymap("n", "<C-L>", ":bnext<CR>")
-- keymap("n", "<C-H>", ":bprevious<CR>")
