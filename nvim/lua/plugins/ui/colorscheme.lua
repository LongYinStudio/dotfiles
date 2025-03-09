return {
	{
		"navarasu/onedark.nvim",
		config = function()
			vim.cmd([[colorscheme onedark]])
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = false,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = { style = "night" },
		enabled = false,
	},
}
