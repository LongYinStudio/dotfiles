return {
	"pmizio/typescript-tools.nvim",
	enabled = false,
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
	config = function()
		require("typescript-tools").setup({
			settings = {
				tsserver_locale = "zh-cn",
			},
		})
	end,
}
