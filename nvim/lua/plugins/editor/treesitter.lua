-- 语法高亮
-- NOTE: 某个出现问题时，修改nvim ~/.local/share/nvim/lazy/nvim-treesitter/lockfile.json里的commit hash到最新，然后执行:TSUpdate! 加对应名称 进行强制重装
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				modules = {},
				-- A list of parser names, or "all" (the listed parsers MUST always be installed)
				ensure_installed = {
					"arduino",
					"bash",
					"c",
					"cmake",
					"cpp",
					"css",
					"dart",
					"dot",
					"func",
					"git_config",
					"git_rebase",
					"gitcommit",
					"gitignore",
					"go",
					"html",
					"hurl",
					"java",
					"javascript",
					"jq",
					"jsdoc",
					"json",
					"json5",
					-- "latex",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"matlab",
					"passwd",
					"perl",
					"php",
					"phpdoc",
					"python",
					"qmljs",
					"query",
					"regex",
					"rego",
					"rust",
					"scss",
					"slint",
					"sql",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"vue",
					"yaml",
				},
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,
				-- List of parsers to ignore installing (or "all")
				ignore_install = { "latex" },
				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
				highlight = { enable = true },
				indent = { enable = true },
				folding = { enable = true },
				autotag = { enable = true },
				-- 不同括号颜色区分
				-- rainbow = {
				-- 	enable = true,
				-- 	extended_mode = true,
				-- 	max_file_lines = nil,
				-- },
			})
		end,
	},
}
