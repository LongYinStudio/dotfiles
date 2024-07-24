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
	{
		"antosha417/nvim-lsp-file-operations", -- 自动修改引用（如：修改vue组件名）
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
}
