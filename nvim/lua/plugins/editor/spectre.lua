return {
	"nvim-pack/nvim-spectre",
	enabled = false, -- 由grug-far替换
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>st", '<cmd>lua require("spectre").toggle()<CR>', {
			desc = "Toggle Spectre",
		})
		vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
			desc = "Search current word",
		})
		vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
			desc = "Search current word",
		})
		vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
			desc = "Search on current file",
		})
	end,
}

-- 类似的 https://github.com/ray-x/sad.nvim https://github.com/gabrielpoca/replacer.nvim
