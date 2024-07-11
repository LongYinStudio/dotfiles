local languages = {
	"lua_ls",
	"html",
	"emmet_ls",
	"cssls",
	"tsserver",
	"vuels",
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
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			for _, language in ipairs(languages) do
				require("lspconfig")[language].setup({
					capabilities = capabilities,
				})
			end
		end,
	},
	{
		"VidocqH/lsp-lens.nvim", -- 显示definition/references/implements
		config = function()
			require("lsp-lens").setup({
				enable = true,
				include_declaration = true, -- Reference include declaration
				sections = { -- Enable / Disable specific request
					definition = true,
					references = true,
					implements = true,
				},
				ignore_filetype = {
					"prisma",
				},
			})
		end,
	},
}
