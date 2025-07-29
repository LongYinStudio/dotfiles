return {
	"stevearc/aerial.nvim",
	enabled = false,
	opts = {},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({
			-- optionally use on_attach to set keymaps when aerial has attached to a buffer
			on_attach = function(bufnr)
				-- Jump forwards/backwards with '{' and '}'
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		})
		-- You probably also want to set a keymap to toggle aerial
		vim.keymap.set("n", "<leader>co", "<cmd>AerialToggle!<CR>", { desc = "Toggle Outline(Aerial)" })
		vim.keymap.set("n", "<leader>To", "<cmd>AerialToggle!<CR>", { desc = "Toggle Outline(Aerial)" })
	end,
}
