return {
	{
		"LongYinStudio/ts-error-translator-plus.nvim",
		opts = {
			lang = "zh-CN",
		},
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		enabled = false,
		config = true,
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
	},
	{
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
	},
}
