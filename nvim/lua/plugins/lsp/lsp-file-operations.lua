return {
	"antosha417/nvim-lsp-file-operations", -- 自动修改引用（如：修改vue组件名）
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-tree.lua",
	},
	config = function()
		require("lsp-file-operations").setup()
	end,
}
