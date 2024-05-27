local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"nvim-tree/nvim-web-devicons",
	"christoomey/vim-tmux-navigator", -- 用ctl-hjkl来定位窗口
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁
		"neovim/nvim-lspconfig",
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"folke/neodev.nvim",
			config = true,
		},
	},
	-- 自动补全
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"L3MON4D3/LuaSnip", -- snippets引擎，不装这个自动补全会出问题
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",
	"hrsh7th/cmp-path", -- 文件路径
	"hrsh7th/cmp-cmdline", -- 补全底部命令行--->tab
	"VidocqH/lsp-lens.nvim", -- 显示definition/references/implements

	require("plugins.treesitter"), -- 语法高亮
	require("plugins.autopairs"), -- 自动补全括号
	require("plugins.autotag"), -- 自动补全标签
	require("plugins.nvim-tree"), -- 文件浏览
	require("plugins.wilder"), -- :cmdline & /搜索
	require("plugins.telescope"), -- 全局搜搜
	require("plugins.conform"), --格式化
	require("plugins.bufferline"), -- buffer分割线
	require("plugins.dropbar"),
	require("plugins.lualine"), -- 状态栏
	require("plugins.comment"), -- gcc和gc注释
	require("plugins.gitsigns"), -- 左则git提示
	require("plugins.toggleterm"), --终端
	require("plugins.notify"), -- 消息提醒
	require("plugins.colorizer"), --显示颜色
	require("plugins.flash"), -- 快速跳转
	require("plugins.scrollbar"),
	require("plugins.surround"),
	require("plugins.indent-blankline"),
	require("plugins.markdown-preview"),
	require("plugins.colorscheme"),
	require("plugins.vim-visual-multi"), -- 多光标[ctrl+n，(neo)vim自带的*就够用了]
	require("plugins.lspkind"), -- lsp 图标
	require("plugins.numb"), -- :{number} 预览
	require("plugins.vim-illuminate"), -- 高亮相同字符
	require("plugins.which-key"), -- 快捷键提示
	require("plugins.todo-comments"),
}
local opts = {} -- 注意要定义这个变量

require("lazy").setup(plugins, opts)
