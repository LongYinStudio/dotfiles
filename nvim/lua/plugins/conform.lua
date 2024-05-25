return {
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
				markdown = { "prettier", "markdownlint" },
				css = { "prettier", "stylelint" },
				scss = { "prettier" },
				sass = { "prettier" },
				less = { "prettier" },
				lua = { "stylua" },
				-- apt/brew install clang-format
				c = { "clang_format" },
				cpp = { "clang_format" },
				-- apt/brew install + 名
				rust = { "rustfmt" },
				sh = { "shellcheck", "shfmt" },
				zsh = { "shfmt", "shellcheck" },
				--google-java-format安装相对复杂(需要准备jdk11以上)
				--1.到https://github.com/google/google-java-format的releases下载google-java-format-*-all-deps.jar
				--2.sudo mv google-java-format-*-all-deps.jar /usr/local/bin/google-java-format.jar
				--3.nvim /usr/local/bin/google-java-format
				--内容:
				--#!/bin/sh
				--/你的jdk_home(jdk11以上)/bin/java -jar /usr/local/bin/google-java-format.jar "$@"
				--4.sudo chmod +x /usr/local/bin/google-java-format
				--5.测试:google-java-format --version
				java = { "google-java-format" },
			},
		})
	end,
}
