local languages = {
	lua_ls = {
		cmd = { "lua-language-server", "--locale=zh-cn" },
		-- 已安装folke/lazydev.nvim，下面的配置不需要
		-- settings = {
		-- 	Lua = {
		-- diagnostics = {
		-- 	-- Get the language server to recognize the `vim` global
		-- 	globals = {
		-- 		"vim",
		-- 	},
		-- },
		-- 	},
		-- },
	},
	html = {},
	emmet_ls = {
		filetypes = { "html", "typescriptreact", "javascriptreact" },
	},
	cssls = {},
	-- ts_ls = {
	-- 	enabled = false,
	-- },
	tsserver = {
		enabled = false,
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					-- location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
					location = vim.fn.stdpath("data")
						.. "/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
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
		-- file_operations = {
		-- 	willRename = { provider = "tsserver", operation = "rename" },
		-- 	willMove = { provider = "tsserver", operation = "move" },
		-- },
	},
	vuels = {},
	volar = {
		filetypes = {
			"vue", -- "typescript", "javascript", "javascriptreact", "typescriptreact",
		},
		init_options = {
			vue = {
				hybridMode = true,
			},
			-- typescript = {
			-- 	tsdk = vim.fn.getcwd() .. "node_modules/typescript/lib",
			--  tsdk = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib"),
			-- },
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
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"vue",
		},
		single_file_support = true,
		settings = {
			complete_function_calls = true,
			vtsls = {
				autoUseWorkspaceTsdk = true,
				enableMoveToFileCodeAction = true,
				experimental = {
					maxInlayHintLength = 30,
					completion = {
						enableServerSideFuzzyMatch = true,
					},
				},
				tsserver = {
					globalPlugins = {
						{
							name = "@vue/typescript-plugin",
							location = vim.fn.stdpath("data")
								.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
							languages = { "vue" },
							configNamespace = "typescript",
							enableForWorkspaceTypeScriptVersions = true,
						},
					},
				},
			},
			javascript = {
				updateImportsOnFileMove = { enabled = "always" },
				suggest = {
					completeFunctionCalls = true,
				},
				inlayHints = {
					enumMemberValues = { enabled = true },
					functionLikeReturnTypes = { enabled = true },
					parameterNames = { enabled = "literals" },
					parameterTypes = { enabled = true },
					propertyDeclarationTypes = { enabled = true },
					variableTypes = { enabled = true },
				},
			},
			typescript = {
				updateImportsOnFileMove = { enabled = "always" },
				-- tsdk = "./node_modules/typescript/lib",
				suggest = {
					completeFunctionCalls = true,
				},
				inlayHints = {
					enumMemberValues = { enabled = true },
					functionLikeReturnTypes = { enabled = true },
					parameterNames = { enabled = "literals" },
					parameterTypes = { enabled = true },
					propertyDeclarationTypes = { enabled = true },
					variableTypes = { enabled = true },
				},
			},
		},
	},
	clangd = {},
	jsonls = {},
	tailwindcss = {},
	bashls = {},
	dockerls = {},
	pyright = {},
	yamlls = {},
	jdtls = {}, -- jdtls 需要jdk17
	typst_lsp = {},
}

-- 取消部分lsp的自动安装
local autoinstall_excluded_servers = { "vuels", "dockerls", "tailwindcss", "pyright", "yamlls", "jdtls", "typst_lsp" }

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

			local on_attach = function(client, bufnr)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				require("lsp_signature").on_attach({}, bufnr)
				nmap("<leader>cr", vim.lsp.buf.rename, "Rename")
				-- nmap("<F2>", vim.lsp.buf.rename, "Rename") -- 禁用，与dap冲突
				nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				nmap("<leader>cs", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
				nmap("gd", vim.lsp.buf.definition, "Goto Definition")
				-- nmap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
				nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
				nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
				nmap("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
				nmap("gt", require("telescope.builtin").lsp_type_definitions, "Goto Type Definition")

				-- Diagnostic keymaps
				nmap("<leader>cD", require("telescope.builtin").diagnostics, "Diagnostics")
				-- nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
				-- nmap("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
				-- nmap("]e", function() vim.diagnostic.goto_next({ severity = "ERROR" }) end, "Next Error")
				-- nmap("[e", function() vim.diagnostic.goto_prev({ severity = "ERROR" }) end, "Prev Error")
				nmap("[d", function()
					vim.diagnostic.jump({ count = -1 })
				end, "Previous diagnostic")
				nmap("]d", function()
					vim.diagnostic.jump({ count = 1 })
				end, "Next diagnostic")
				nmap("[e", function()
					vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
				end, "Previous error")
				nmap("]e", function()
					vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
				end, "Next error")
				nmap("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
				nmap("<leader>cq", vim.diagnostic.setloclist, "Set Loc List")

				nmap("K", vim.lsp.buf.hover, "Hover Documentation") -- 使用KK聚焦到hover弹框，q隐藏
				nmap("P", vim.lsp.buf.signature_help, "Signature Documentation") -- P(arameter) L键已经被lualine使用，详情执行 :verbose map L

				-- Lesser used LSP functionality
				-- nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace Symbols")
				-- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				-- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				-- nmap("<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "[W]orkspace [L]ist Folders")

				-- 启用内嵌提示 (Neovim 0.10+)
				if vim.lsp.inlay_hint and client.supports_method("textDocument/inlayHint") then
					-- vim.lsp.inlay_hint(bufnr, true)
					nmap("<leader>ch", function()
						local reversed_value = not vim.lsp.inlay_hint.is_enabled({})
						vim.lsp.inlay_hint.enable(reversed_value)
					end, "Toggle Inlay Iint")
				end

				-- 格式化
				if client.supports_method("textDocument/formatting") then
					-- Format on save 由 conform 代替
					-- vim.api.nvim_create_autocmd("BufWritePre", {
					-- 	group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
					-- 	buffer = bufnr,
					-- 	callback = function()
					-- 		vim.lsp.buf.format({ bufnr = bufnr })
					-- 	end,
					-- })
					-- Format on key
					vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", function(_)
						if vim.lsp.buf.format then
							vim.lsp.buf.format()
						elseif vim.lsp.buf.formatting then
							vim.lsp.buf.formatting()
						end
					end, { desc = "Format current buffer with LSP" })
					nmap("<leader>cf", "<cmd>LspFormat<cr>")
				end
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			mason_lspconfig.setup_handlers({
				function(server_name)
					local server = languages[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}, {
						textDocument = {
							foldingRange = {
								dynamicRegistration = false,
								lineFoldingOnly = true,
							},
						},
					})
					server.on_attach = on_attach
					require("lspconfig")[server_name].setup(server)
				end,
			})

			-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {	border = "rounded" })

			-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			-- for type, icon in pairs(signs) do
			-- 	local hl = "DiagnosticSign" .. type
			-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			-- end

			vim.diagnostic.config({
				-- 在侧边栏（sign column）显示诊断符号
				signs = {
					text = {
						-- [vim.diagnostic.severity.ERROR] = " ",
						-- [vim.diagnostic.severity.WARN] = " ",
						-- [vim.diagnostic.severity.INFO] = " ",
						-- [vim.diagnostic.severity.HINT] = "󰠠 ",
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = "󰬐 ",
					},
					texthl = {
						[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
						[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
						[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
						[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
				-- 是否在代码右侧显示诊断信息的虚拟文本（如 `Error: Expected semicolon`） virtual_text=true/false
				virtual_text = {
					prefix = "●",
				},
				underline = true, -- 是否对诊断范围内的代码添加下划线
				update_in_insert = false, -- 是否在插入模式下更新诊断信息（如输入时实时反馈）
				severity_sort = false, -- 诊断信息的严重性排序（按严重程度排序）
				-- 是否启用虚拟行（virtual lines）显示诊断信息（实验性功能）
				-- 可结合 virtual_text 实现更灵活的显示方式
				virtual_lines = false,
				-- 是否在命令行显示诊断信息（如 `:echo` 输出）
				message = true,
				highlight = true, -- 是否启用诊断高亮组
				line_numbers = true, -- 是否启用诊断行号高亮（在行号列显示诊断颜色）
			})
		end,
	},
}
