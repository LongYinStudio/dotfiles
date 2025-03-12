local languages = {
	lua_ls = {
		-- 已安装folke/lazydev.nvim，下面的配置不需要
		-- settings = {
		-- 	Lua = {
		-- 		diagnostics = {
		-- 			-- Get the language server to recognize the `vim` global
		-- 			globals = {
		-- 				"vim",
		-- 			},
		-- 		},
		-- 	},
		-- },
	},
	html = {},
	emmet_ls = {
		filetypes = {
			"html",
		},
	},
	cssls = {},
	tsserver = {
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = vim.fn.stdpath("data")
						.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
					languages = { "vue" },
				},
			},
		},
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
		single_file_support = true,
		file_operations = {
			willRename = { provider = "tsserver", operation = "rename" },
			willMove = { provider = "tsserver", operation = "move" },
		},
	},
	vuels = {},
	volar = {
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		init_options = {
			vue = {
				hybridMode = true,
			},
			-- typescript = {
			-- 	tsdk = vim.fn.getcwd() .. "node_modules/typescript/lib",
			-- },
			-- 					typescript = {
			-- tsdk = vim.fn.expand(
			-- 	"$HOME/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib"
			-- ),
		},
		settings = {
			typescript = {
				inlayHints = {
					enumMemberValues = { enabled = true },
					functionLikeReturnTypes = {
						enabled = true,
					},
					propertyDeclarationTypes = {
						enabled = true,
					},
					parameterTypes = {
						enabled = true,
						suppressWhenArgumentMatchesName = true,
					},
					variableTypes = { enabled = true },
				},
			},
		},
	},
	vtsls = {
		enabled = false,
		-- tsserver = {
		-- 	globalPlugins = {
		-- 		{
		-- 			name = "@vue/typescript-plugin",
		-- 			location = vim.fn.stdpath("data")
		-- 				.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
		-- 			languages = { "vue" },
		-- 			configNamespace = "typescript",
		-- 			enableForWorkspaceTypeScriptVersions = true,
		-- 		},
		-- 	},
		-- },
		-- filetypes = {
		-- 	"javascript",
		-- 	"javascriptreact",
		-- 	"javascript.jsx",
		-- 	"typescript",
		-- 	"typescriptreact",
		-- 	"typescript.tsx",
		-- },
		-- settings = {
		-- 	complete_function_calls = true,
		-- 	vtsls = {
		-- 		enableMoveToFileCodeAction = true,
		-- 		autoUseWorkspaceTsdk = true,
		-- 		experimental = {
		-- 			maxInlayHintLength = 30,
		-- 			completion = {
		-- 				enableServerSideFuzzyMatch = true,
		-- 			},
		-- 		},
		-- 	},
		-- 	typescript = {
		-- 		updateImportsOnFileMove = { enabled = "always" },
		-- 		suggest = {
		-- 			completeFunctionCalls = true,
		-- 		},
		-- 		inlayHints = {
		-- 			enumMemberValues = { enabled = true },
		-- 			functionLikeReturnTypes = { enabled = true },
		-- 			parameterNames = { enabled = "literals" },
		-- 			parameterTypes = { enabled = true },
		-- 			propertyDeclarationTypes = { enabled = true },
		-- 			variableTypes = { enabled = false },
		-- 		},
		-- 	},
		-- },
	},
	clangd = {},
	jsonls = {},
	tailwindcss = {},
	bashls = {},
	dockerls = {},
	pyright = {},
	yamlls = {},
	jdtls = {}, -- jdtls 需要jdk17
}

-- 取消部分lsp的自动安装
local autoinstall_excluded_servers = { "vuels", "dockerls", "tailwindcss", "pyright", "yamlls", "jdtls" }

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
				nmap("<leader>cD", require("telescope.builtin").diagnostics, "Diagnostics")
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

				-- See `:help K` for why this keymap  使用KK聚焦到hover弹框，q隐藏
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

				vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", function(_)
					if vim.lsp.buf.format then
						vim.lsp.buf.format()
					elseif vim.lsp.buf.formatting then
						vim.lsp.buf.formatting()
					end
				end, { desc = "Format current buffer with LSP" })
				-- Format on save
				-- vim.cmd("autocmd BufWritePre <buffer> LspFormat")
				nmap("<leader>cf", "<cmd>LspFormat<cr>")
			end

			mason_lspconfig.setup_handlers({
				function(server_name)
					local server = languages[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					server.on_attach = on_attach
					require("lspconfig")[server_name].setup(server)
				end,
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})

			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
			})
		end,
	},
}
