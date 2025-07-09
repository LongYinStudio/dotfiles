return {
	{
		"navarasu/onedark.nvim",
		-- enabled = false,
		config = function()
			vim.cmd([[colorscheme onedark]])
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = false,
		config = function()
			vim.cmd([[colorscheme catppuccin-macchiato]])
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = { style = "night" },
		enabled = false,
		config = function()
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},
}
