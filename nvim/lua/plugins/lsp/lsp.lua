local languages = {
	"lua_ls",
	"html",
	"emmet_ls",
	"cssls",
	"tsserver",
	-- "vuels",
	"volar",
	"clangd",
	"jsonls",
	"tailwindcss",
	"bashls",
	"dockerls",
	"pyright",
	"yamlls",
}

return {
	-- lsp installation
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			cmd = "Mason",
			opts = {
				ui = {
					border = "rounded",
					width = 0.8,
					height = 0.7,
					icons = {
						package_installed = "󰺧",
						package_pending = "",
						package_uninstalled = "󰺭",
					},
				},
			},
		},
		opts = {
			ensure_installed = languages,
			automatic_installation = true,
		},
	},

	-- lsp
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			{ "folke/neodev.nvim", opts = {} },
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			for _, language in ipairs(languages) do
				require("lspconfig")[language].setup({
					capabilities = capabilities,
				})
			end
			require("lspconfig")["volar"].setup({
				capabilities = capabilities,
				init_options = {
					typescript = {
						tsdk = vim.fn.expand(
							"$HOME/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib"
						),
					},
				},
			})
		end,
	},
}
