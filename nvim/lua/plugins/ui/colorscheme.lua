return {
	{
		"navarasu/onedark.nvim",
		enabled = false,
		config = function()
			vim.cmd([[colorscheme onedark]])
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		-- enabled = false,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false, -- disables setting the background color.
				float = {
					transparent = false, -- enable transparent floating windows
					solid = false, -- use solid styling for floating windows, see |winborder|
				},
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		-- opts = { style = "night" },
		enabled = false,
		config = function()
			vim.cmd([[colorscheme tokyonight-moon]]) -- day | night | moon | storm
		end,
	},
}
