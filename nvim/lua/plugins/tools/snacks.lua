return {
	"folke/snacks.nvim",
	enabled = false,
	priority = 1000,
	lazy = false,
	opts = {
		image = {
			enable = true,
			doc = {
				enable = true,
				inline = true,
			},
		},
		bigfile = { enabled = false },
		dashboard = { enabled = false },
		explorer = { enabled = false },
		indent = { enabled = false },
		input = { enabled = false },
		notifier = {
			enabled = false,
			timeout = 3000,
		},
		picker = { enabled = true },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = true },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		local keymap = vim.keymap.set
		local snacks = require("snacks")
		local picker = snacks.picker
		keymap("n", "<leader>fn", picker.files, { desc = "snacks picker" })
	end,
}
