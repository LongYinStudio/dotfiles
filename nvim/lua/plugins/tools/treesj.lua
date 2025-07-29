return {
	"Wansmer/treesj",
	enable = false,
	-- keys = {
	-- 	{
	-- 		"<leader>cJ", -- gJ
	-- 		function()
	-- 			require("treesj").join()
	-- 		end,
	-- 		desc = "Treesj Join",
	-- 	},
	-- 	{
	-- 		"<leader>cS", -- gS
	-- 		function()
	-- 			require("treesj").split()
	-- 		end,
	-- 		desc = "Treesj Split",
	-- 	},
	-- 	{
	-- 		"<leader>cT", -- gT
	-- 		function()
	-- 			require("treesj").toggle()
	-- 		end,
	-- 		desc = "Treesj Toggle",
	-- 	},
	-- },
	keys = {
		{ "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
	},
	opts = {
		use_default_keymaps = false,
	},
}
