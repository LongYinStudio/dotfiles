local languages = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = {
						"vim",
					},
				},
			},
		},
	},
	html = {},
	emmet_ls = {},
	cssls = {},
	tsserver = {},
	vuels = {},
	volar = {},
	clangd = {},
	jsonls = {},
	tailwindcss = {},
	bashls = {},
	dockerls = {},
	pyright = {},
	yamlls = {},
}

-- 取消部分lsp的自动安装
-- volar单独安装，最新版本2.0.x在neovim不好配置 MasonInstall vue-language-server@1.8.27
local autoinstall_excluded_servers = { "volar", "vuels", "dockerls", "tailwindcss", "pyright", "yamlls" }

return {
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			{
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
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				-- ensure_installed = vim.tbl_keys(languages),
				ensure_installed = vim.tbl_filter(function(server_name)
					return not vim.tbl_contains(autoinstall_excluded_servers, server_name)
				end, vim.tbl_keys(languages)),
				automatic_installation = true,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local on_attach = function(_, bufnr)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				require("lsp_signature").on_attach({}, bufnr)
				-- TODO: 查看LazyVim 的rename_file
				nmap("<leader>cr", vim.lsp.buf.rename, "Rename")
				nmap("<F2>", vim.lsp.buf.rename, "Rename")
				nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				nmap("<leader>cs", require("telescope.builtin").lsp_document_symbols, "Document Symbols")

				-- nmap("gd", vim.lsp.buf.definition, "Goto Definition")
				nmap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
				nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
				nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
				nmap("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
				nmap("gt", require("telescope.builtin").lsp_type_definitions, "Goto Type Definition")

				-- Diagnostic keymaps
				nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
				nmap("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
				nmap("]e", function()
					vim.diagnostic.goto_next({ severity = "ERROR" })
				end, "Next Error")
				nmap("[e", function()
					vim.diagnostic.goto_prev({ severity = "ERROR" })
				end, "Prev Error")
				nmap("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
				nmap("<leader>cq", vim.diagnostic.setloclist, "Set Loc List")

				-- See `:help K` for why this keymap
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				-- P(arameter) L键已经被lualine使用，详情执行 :verbose map L
				nmap("P", vim.lsp.buf.signature_help, "Signature Documentation")

				-- Lesser used LSP functionality
				-- nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace Symbols")
				-- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				-- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				-- nmap("<leader>wl", function()
				-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				-- end, "[W]orkspace [L]ist Folders")

				nmap("<leader>ch", function()
					local reversed_value = not vim.lsp.inlay_hint.is_enabled({})
					vim.lsp.inlay_hint.enable(reversed_value)
				end, "Toggle Inlay Iint")
			end

			mason_lspconfig.setup_handlers({
				function(server_name)
					local server = languages[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					server.on_attach = on_attach
					require("lspconfig")[server_name].setup(server)
				end,
				-- 下面是为了解决volar@2.0.x，已弃用，改用老版本volar@1.8.27
				-- 手动配置 volar
				-- volar = function()
				-- 	require("lspconfig").volar.setup({
				-- 		cmd = { "/home/longyinstudio/.nvm/versions/node/v20.11.1/bin/vue-language-server", "--stdio" },
				-- 		capabilities = capabilities,
				-- 		on_attach = on_attach,
				-- 	})
				-- end,
			})

			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
		end,
	},
}
