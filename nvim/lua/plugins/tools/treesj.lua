return {
	"Wansmer/treesj",
	enabled = false,
	-- keys = {
	-- 	{
	-- 		"<leader>cJ",
	-- 		function()
	-- 			require("treesj").join()
	-- 		end,
	-- 		desc = "Treesj Join",
	-- 	},
	-- 	{
	-- 		"<leader>cS",
	-- 		function()
	-- 			require("treesj").split()
	-- 		end,
	-- 		desc = "Treesj Split",
	-- 	},
	-- 	{
	-- 		"<leader>cT",
	-- 		function()
	-- 			require("treesj").toggle()
	-- 		end,
	-- 		desc = "Treesj Toggle",
	-- 	},
	-- },
	keys = {
		{
			"gJ",
			function()
				require("treesj").join()
			end,
		},
		{
			"gS",
			function()
				require("treesj").split()
			end,
		},
	},
	opts = {
		use_default_keymaps = false,
	},
}
