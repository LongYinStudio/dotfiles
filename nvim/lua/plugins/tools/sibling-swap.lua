return {
	"Wansmer/sibling-swap.nvim",
	enabled = false,
	keys = {
		{ "<C-.>", mode = { "n" } },
		{ "<C-,>", mode = { "n" } },
		-- { "<space>,", mode = { "n" } },
		-- { "<space>.", mode = { "n" } },
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("sibling-swap").setup({
			allowed_separators = {
				",",
				";",
				"and",
				"or",
				"&&",
				"&",
				"||",
				"|",
				"==",
				"===",
				"!=",
				"!==",
				"-",
				"+",
				["<"] = ">",
				["<="] = ">=",
				[">"] = "<",
				[">="] = "<=",
			},
			use_default_keymaps = false,
			keymaps = {
				["<C-.>"] = "swap_with_right",
				["<C-,>"] = "swap_with_left",
				["<C-S-.>"] = "swap_with_right_with_opp",
				["<C-S-,>"] = "swap_with_left_with_opp",
			},
			ignore_injected_langs = false,
		})
	end,
}
