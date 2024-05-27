return {
	"soulis-1256/eagle.nvim",
	config = function()
		vim.o.mousemoveevent = true
		require("eagle").setup({})
	end,
}
