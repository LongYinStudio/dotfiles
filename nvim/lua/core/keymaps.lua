vim.g.mapleader = ";"

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

-- ---------- 插入模式 ---------- ---
keymap("i", "jk", "<ESC>")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
-- v 1行，上下5行
keymap('v', 'K', '5k', opts)
keymap('v', 'J', '5j', opts)
keymap('v', 'H', '0', opts)
keymap('v', 'L', '$', opts)

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap("n", "<leader>sv", "<C-w>v") -- 水平新增窗口
keymap("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口

-- 取消高亮
keymap("n", "<leader>nh", ":nohl<CR>")

-- 切换buffer
keymap("n", "<C-L>", ":bnext<CR>")
keymap("n", "<C-H>", ":bprevious<CR>")

-- bufferline 左右切换
keymap("n", "<leader>h", ":BufferLineCyclePrev<CR>", opt)
keymap("n", "<leader>l", ":BufferLineCycleNext<CR>", opt)

-- ---------- 插件 ---------- ---
-- nvim-lspconfig
keymap("n", "<leader>gd", vim.lsp.buf.definition, bufopts)                             --定义
keymap("n", "<leader>gr", vim.lsp.buf.references, bufopts)                             --引用
keymap("n", "<leader>rn", vim.lsp.buf.rename, bufopts)                                 --重命名
keymap("n", "<F2>", vim.lsp.buf.rename, bufopts)                                       --重命名
keymap("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)                            --列出code action
keymap("n", "<leader>cf", function() vim.lsp.buf.format { async = true } end, bufopts) --normal下格式
keymap("v", "<leader>cf", function() vim.lsp.buf.format { async = true } end, bufopts) --view下格式化
-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>")
