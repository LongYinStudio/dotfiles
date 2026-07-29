-- 语法高亮（nvim-treesitter 已切换到 main 分支重写版的新 API，需 nvim 0.12+）
-- NOTE: parser 出问题可执行 :TSUpdate[!] <name> 强制更新/重装，:TSInstall <name> 补装
-- NOTE: 依赖系统级 tree-sitter-cli（>=0.26.1，用包管理器装，不能用 npm 版）、tar、curl、C 编译器
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false, -- 官方明确不支持懒加载
		build = ":TSUpdate",
		config = function()
			-- 新 API 没有 ensure_installed：这里启动时补装缺失的 parser（已装的自动跳过）
			require("nvim-treesitter").install({
				"bash",
				"c",
				"cmake",
				"cpp",
				"css",
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
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"rust",
				"scss",
				"sql",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"yaml",
			})

			-- 新 API 不再内置 highlight 模块，需按 FileType 手动启动（buf 已激活则跳过）
			local group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				desc = "Start treesitter highlighting",
				callback = function(args)
					if not vim.treesitter.highlighter.active[args.buf] then
						pcall(vim.treesitter.start, args.buf)
					end
				end,
			})
		end,
	},
}
