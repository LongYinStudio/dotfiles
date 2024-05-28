return {
	"kevinhwang91/nvim-ufo",
	event = { "BufRead" },
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			config = function()
				local builtin = require("statuscol.builtin")
				require("statuscol").setup({
					ft_ignore = {
						"neo-tree",
						"NvimTree",
						"alpha",
						"undotree",
						"diff",
						"git",
						"fzf",
						"toggleterm",
						"dashboard",
						"dapui_watches",
						"dap-repl",
						"dapui_console",
						"dapui_stacks",
						"dapui_breakpoints",
						"dapui_scopes",
						"help",
						"vim",
						"dashboard",
						"Trouble",
						"noice",
						"lazy",
						"nvdash",
						"toggleterm",
						"Outline",
						"neotest",
						"neotest-summary",
						"neotest-output-panel",
						"spectre_panel",
						"TelescopePrompt",
						"TelescopeResults",
					},
					relculright = true,
					segments = {
						{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
						{ text = { "%s" }, click = "v:lua.ScSa" },
						{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
					},
				})
			end,
		},
	},
	keys = {
		-- NOTE: 最常用的是za（切换当前/全部），zc/zC（折叠当前/全部）zo/zO（打开当前/全部）
		-- NOTE: 还有很多快捷键没有自定义，按z后which-key会提示
		{
			"zR",
			function()
				require("ufo").openAllFolds()
			end,
			desc = "󱃄 Open all folds",
		},
		{
			"zM",
			function()
				require("ufo").closeAllFolds()
			end,
			desc = "󱃄 Close all folds",
		},
		{
			"zr",
			function()
				require("ufo").openFoldsExceptKinds()
			end,
			desc = "󱃄 Fold less",
		},
		{
			"zm",
			function()
				require("ufo").closeFoldsWith()
			end,
			desc = "󱃄 Fold more",
		},
		{
			"zp",
			function()
				require("ufo").peekFoldedLinesUnderCursor()
			end,
			desc = "󱃄 Peek fold",
		},
		{
			"z1",
			function()
				require("ufo").closeFoldsWith(1)
			end,
			desc = "󱃄 Close L1 Folds",
		},
		{
			"z2",
			function()
				require("ufo").closeFoldsWith(2)
			end,
			desc = "󱃄 Close L2 Folds",
		},
		{
			"z3",
			function()
				require("ufo").closeFoldsWith(3)
			end,
			desc = "󱃄 Close L3 Folds",
		},
		{
			"z4",
			function()
				require("ufo").closeFoldsWith(4)
			end,
			desc = "󱃄 Close L4 Folds",
		},
	},
	opts = {
		provider_selector = function()
			return { "treesitter", "indent" }
		end,
		fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = (" 󰡏 %d "):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end,
		preview = {
			win_config = {
				border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
				winblend = 0,
				winhighlight = "Normal:LazyNormal",
			},
			mappings = {
				scrollB = "<C-b>",
				scrollF = "<C-f>",
				scrollU = "<C-u>",
				scrollD = "<C-d>",
				scrollE = "<C-e>",
				scrollY = "<C-y>",
				jumpTop = "gg",
				jumpBot = "G",
				close = "q",
				switch = "K",
				trace = "<CR>",
			},
		},
	},
}
