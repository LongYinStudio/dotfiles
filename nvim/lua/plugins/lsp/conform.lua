-- 格式化
return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = false,
				},
				formatters_by_ft = {
					vue = { "prettier" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					jsonc = { "prettier" },
					html = { "prettier" },
					yaml = { "prettier" },
					xml = { "prettier" },
					xhtml = { "prettier" },
					markdown = { "prettier" },
					css = { "prettier", "stylelint" },
					scss = { "prettier" },
					sass = { "prettier" },
					less = { "prettier" },
					lua = { "stylua" },
					c = { "clang_format" },
					cpp = { "clang_format" },
					rust = { "rustfmt" }, --  rustfmt 得由rustup安装 不能用mason (rustup component add rustfmt)
					sh = { "shellcheck", "shfmt" },
					zsh = { "shfmt", "shellcheck" },
					java = { "clang_format", "google-java-format" }, -- google-java-format 不自动安装
					-- typst = { "typstfmt" },
				},
			})
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				local packages = { "google-java-format" }
				vim.cmd("MasonInstall " .. table.concat(packages, " "))
			end, {})
		end,
	},
}
