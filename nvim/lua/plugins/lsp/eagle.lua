-- 鼠标悬浮，查看当前函数、关键字等来自lsp的描述
return {
	"soulis-1256/eagle.nvim",
	config = function()
		vim.o.mousemoveevent = true
		require("eagle").setup({})
	end,
}
