return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			config = function()
				local builtin = require("statuscol.builtin")
				require("statuscol").setup({
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
			"zZ",
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
		preview = {
			win_config = {
				border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
				winblend = 0,
				winhighlight = "Normal:LazyNormal",
			},
			mappings = {
				scrollU = "<C-u>",
				scrollD = "<C-d>",
				jumpTop = "[",
				jumpBot = "]",
			},
		},
	},
}
