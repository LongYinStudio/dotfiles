return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			vue = { "eslint_d" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
		}

		lint.linters.codespell.args = { "--ignore-words ~/.config/codespell/ignore_words" }

		vim.api.nvim_create_user_command("InstallAllLinter", function()
			local packages = { "eslint_d" }
			vim.cmd("MasonInstall " .. table.concat(packages, " "))
		end, {})

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint()

				-- You can call `try_lint` with a linter name or a list of names to always
				-- run specific linters, independent of the `linters_by_ft` configuration
				-- require("lint").try_lint("cspell") -- 自带的就够用了
			end,
		})
	end,
}
