vim.g.mapleader = ";"

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

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
keymap("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" }) -- 水平新增窗口
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" }) -- 垂直新增窗口
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
keymap("n", "<leader>nh", ":nohl<CR>")
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
-- new file
keymap("n", "<leader>nf", "<cmd>enew<cr>", { desc = "New File" })

-- ---------- 插件 ---------- ---
-- nvim-lspconfig
keymap("n", "<leader>gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Goto Definition" }) --定义
keymap("n", "<leader>gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "Goto References" }) --引用
keymap("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename" }) --重命名
keymap("n", "<F2>", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename" }) --重命名
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code Action" }) --列出code action
-- toggleterm
keymap("n", "<leader>`", "<Cmd>ToggleTerm<CR>", { desc = "ToggleTerm" })
keymap("n", "<leader>tf", "<Cmd>ToggleTerm direction=float<CR>", { desc = "ToggleTerm float" })
keymap("n", "<leader>th", "<Cmd>ToggleTerm direction=horizontal<CR>", { desc = "ToggleTerm horizontal split" })
keymap("n", "<leader>tv", "<Cmd>ToggleTerm direction=vertical<CR>", { desc = "ToggleTerm vertical split" })
keymap("n", "<leader>tt", "<Cmd>ToggleTerm direction=tab<CR>", { desc = "ToggleTerm tab split" })
