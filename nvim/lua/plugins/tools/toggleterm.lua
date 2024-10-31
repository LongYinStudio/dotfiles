return {
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				on_create = function()
					vim.opt_local.foldcolumn = "0"
					vim.opt_local.signcolumn = "no"
				end,
				on_open = function(terminal)
					local nvimtree_view = require("nvim-tree.view")
					if nvimtree_view.is_visible() and terminal.direction == "horizontal" then
						require("nvim-tree.api").tree.toggle({ find_file = false, focus = false })
						require("nvim-tree.api").tree.toggle({ find_file = false, focus = false })
					end
				end,
				open_mapping = [[<C-t>]], -- 0-9 加 C-t 可以切换终端, :ToggleTermToggleAll 可以查看所有
				start_in_insert = true,
				direction = "horizontal", --float/vertical/tab
				float_opts = {
					border = "rounded",
					winblend = 0, -- transparent
					--zindex = <value>,
					title_pos = "center",
				},
				auto_scroll = true,
				terminal_mappings = true,
				insert_mappings = true,
				shading_factor = -10,
			})
			local keymap = vim.keymap.set
			-- keymap({ "n", "t" }, "<leader>`", "<Cmd>ToggleTerm<CR>", { desc = "ToggleTerm" })
			keymap("n", "<leader>tf", "<Cmd>ToggleTerm direction=float<CR>", { desc = "ToggleTerm Float" })
			keymap(
				"n",
				"<leader>th",
				"<Cmd>ToggleTerm direction=horizontal<CR>",
				{ desc = "ToggleTerm Horizontal split" }
			)
			keymap("n", "<leader>tv", "<Cmd>ToggleTerm direction=vertical<CR>", { desc = "ToggleTerm Vertical split" })
			keymap("n", "<leader>tt", "<Cmd>ToggleTerm direction=tab<CR>", { desc = "ToggleTerm Tab split" })
			keymap("n", "<leader>ta", "<Cmd>ToggleTermToggleAll<CR>", { desc = "ToggleTerm ToggleAll" })
		end,
	},
}
