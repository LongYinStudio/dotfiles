-- Modes
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_mode = "v",
--  visual_block_mode = "x",
--  term_mode = "t",
--  command_mode = "c",

vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

-- 将分号映射为冒号
keymap({ "n", "x" }, ";", ":")

-- 使用黑洞寄存器配置 c, C, d, D, s, S 命令
keymap({ "n", "v" }, "c", '"_c', opts)
keymap({ "n", "v" }, "C", '"_C', opts)
keymap({ "n", "v" }, "d", '"_d', opts)
keymap({ "n", "v" }, "D", '"_D', opts)
-- keymap({ "n", "v" }, "s", '"_s', opts)
-- keymap({ "n", "v" }, "S", '"_S', opts)

-- 单行或多行移动
keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- save file
keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- ---------- 插入模式 ---------- ---
keymap("i", "jk", "<ESC>")

-- ---------- 视觉模式 ---------- ---
-- H一行开始 L一行结束
keymap("v", "H", "0", opts)
keymap("v", "L", "$", opts)
-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap("n", "<leader>wv", "<C-w>v", { desc = "Split Window vertical" }) -- 水平新增窗口
keymap("n", "<leader>wh", "<C-w>s", { desc = "Split Window horizontal" }) -- 垂直新增窗口
keymap("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
-- Resize window using <ctrl> arrow keys
-- FIX: Ctrl+Up/Down 和插件 vim-visual-multi 默认的快捷键冲突
-- keymap("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
-- keymap("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- 取消高亮
keymap("n", "<leader>H", ":nohl<CR>", { desc = "no highlight search" })
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
-- new file
keymap("n", "<leader>F", "<cmd>enew<cr>", { desc = "New File" })
-- number
-- keymap("n", "<leader>Tn", "<cmd>set nu!<CR>", { desc = "toggle line number" })
-- keymap("n", "<leader>TN", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- -------- toggles --------- ---
keymap("n", "<leader>Tw", function()
	require("utils.toggles").wrap()
end, { desc = "Toggle wrap" })
keymap("n", "<leader>Ts", function()
	require("utils.toggles").spell()
end, { desc = "Toggle spell" })
keymap("n", "<leader>Tn", function()
	require("utils.toggles").number()
end, { desc = "Toggle number" })

-- ---------- 插件 ---------- ---
-- nvim-lspconfig
-- TODO: 查看LazyVim 的rename_file
keymap("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Goto Definition" }) --定义
keymap("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "Goto References" }) --引用
keymap("n", "<leader>cr", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename" }) --重命名
keymap("n", "<F2>", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename" }) --重命名
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code Action" }) --列出code action
