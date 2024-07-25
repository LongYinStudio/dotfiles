return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.opt.termguicolors = true

		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "NvimTree",
						-- filetype = "neo-tree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		})
		vim.keymap.set("n", "H", "<cmd>bp<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "L", "<cmd>bn<CR>", { noremap = true, silent = true })
		vim.keymap.set(
			"n",
			"<leader>bc",
			"<cmd>bd<CR>",
			{ noremap = true, silent = true, desc = "Close current buffer" }
		)
		vim.keymap.set(
			"n",
			"<leader>bl",
			"<cmd>BufferLineCloseRight<CR>",
			{ noremap = true, silent = true, desc = "Close buffers on the right" }
		)
		vim.keymap.set(
			"n",
			"<leader>bh",
			"<cmd>BufferLineCloseLeft<CR>",
			{ noremap = true, silent = true, desc = "Close buffers on the left" }
		)
		vim.keymap.set(
			"n",
			"<leader>bo",
			"<cmd>BufferLineCloseOthers<CR>",
			{ noremap = true, silent = true, desc = "Close other buffers" }
		)
		vim.keymap.set(
			"n",
			"<leader>bt",
			"<cmd>BufferLinePick<CR>",
			{ noremap = true, silent = true, desc = "Go to buffer (Pick)" }
		)
		vim.keymap.set(
			"n",
			"<leader>be",
			"<cmd>BufferLinePickClose<CR>",
			{ noremap = true, silent = true, desc = "Close buffer (Pick)" }
		)
		vim.keymap.set(
			"n",
			"<leader>bp",
			"<cmd>BufferLineTogglePin<CR>",
			{ noremap = true, silent = true, desc = "Toggle Pin" }
		)
		vim.keymap.set(
			"n",
			"<leader>bP",
			"<cmd>BufferLineGroupClose ungrouped<CR>",
			{ noremap = true, silent = true, desc = "Delete Non-Pinned Buffers" }
		)
	end,
}
