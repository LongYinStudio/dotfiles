-- TODO: 加入联动nvim-ufo、vim-visual-multi配置（参照github）
return {
	"kevinhwang91/nvim-hlslens",
	event = "VeryLazy",
	config = function()
		require("hlslens").setup({
			calm_down = false,
			nearest_only = true,
			nearest_float_when = "never",
		})

		vim.api.nvim_set_keymap(
			"n",
			"n",
			[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
			{ desc = "Next search result", silent = true }
		)

		vim.api.nvim_set_keymap(
			"n",
			"N",
			[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
			{ desc = "Previous Search Result", silent = true }
		)

		vim.api.nvim_set_keymap(
			"n",
			"*",
			[[*<Cmd>lua require('hlslens').start()<CR>]],
			{ desc = "Next Search Result Highlighted", silent = true }
		)

		vim.api.nvim_set_keymap(
			"n",
			"#",
			[[#<Cmd>lua require('hlslens').start()<CR>]],
			{ desc = "Previous Search Result Highlighted", silent = true }
		)

		vim.api.nvim_set_keymap(
			"n",
			"g*",
			[[g*<Cmd>lua require('hlslens').start()<CR>]],
			{ desc = "Mark Current Word And Search Forward", silent = true }
		)

		vim.api.nvim_set_keymap(
			"n",
			"g#",
			[[g#<Cmd>lua require('hlslens').start()<CR>]],
			{ desc = "Mark Current Workd and Search Backwards" }
		)
	end,
}
