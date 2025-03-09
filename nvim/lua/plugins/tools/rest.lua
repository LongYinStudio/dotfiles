return {
	"rest-nvim/rest.nvim",
	ft = "http",
	event = { "VeryLazy" },
	keys = {
		-- 另外的
		-- :Rest run {name}          Run request with name {name}
		-- :Rest env set {path}      Register .env file to current .http file
		{ "<CR>", "<Cmd>Rest run<CR>", desc = "Rest: Run request under the cursor", ft = "http" },
		{ "<leader>rr", "<Cmd>Rest run<CR>", desc = "Rest: Run request under the cursor", ft = "http" },
		{ "<leader>ro", "<Cmd>Rest open<CR>", desc = "Rest: Open result pane", ft = "http" },
		{ "<leader>rl", "<Cmd>Rest last<CR>", desc = "Rest: Run last request", ft = "http" },
		{ "<leader>rL", "<Cmd>Rest logs<CR>", desc = "Rest: Edit logs file", ft = "http" },
		{ "<leader>rc", "<Cmd>Rest cookies<CR>", desc = "Rest: Edit cookies file", ft = "http" },
		{
			"<leader>re",
			"<Cmd>Rest env show<CR>",
			desc = "Rest: Show dotenv file registered to current .http file",
			ft = "http",
		},
		{
			"<leader>rE",
			"<Cmd>Rest env select<CR>",
			desc = "Rest: Select & register .env file with vim.ui.select()",
			ft = "http",
		},
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "http")
		end,
	},
	-- config = function()
	-- 	vim.api.nvim_create_autocmd("FileType", {
	-- 		pattern = "json",
	-- 		callback = function(ev)
	-- 			vim.bo[ev.buf].formatprg = "jq"
	-- 		end,
	-- 	})
	-- end,
}
