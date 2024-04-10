return {
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<leader>`]],
				-- 打开新终端后自动进入插入模式
				start_in_insert = true,
				-- 打开方式
				direction = "horizontal", --float/vertical/tab
			})
		end,
	},
}
