return {
	"hinell/duplicate.nvim",
	event = "VeryLazy",
	keys = {
		{ "<S-A-Up>", "<Cmd>LineDuplicate -1<CR>", mode = { "n" }, desc = "Duplicate line up" },
		{ "<S-A-Down>", "<Cmd>LineDuplicate +1<CR>", mode = { "n" }, desc = "Duplicate line down" },
		-- Visual-mode commands
		{ "<S-A-Up>", "<Cmd>VisualDuplicate -1<CR>", mode = { "x" }, desc = "Duplicate block up" },
		{ "<S-A-Down>", "<Cmd>VisualDuplicate +1<CR>", mode = { "x" }, desc = "Duplicate block down" },
	},
}
