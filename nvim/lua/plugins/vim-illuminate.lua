return {
	"RRethy/vim-illuminate",
	event = "BufEnter",
	config = function()
		require("illuminate").configure({
			min_count_to_highlight = 2,
			delay = 160,
			providers = { "lsp", "treesitter" },
		})
	end,
}
