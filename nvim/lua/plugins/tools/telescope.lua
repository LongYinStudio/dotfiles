-- 全局搜搜
-- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local status, actions = pcall(require, "telescope.actions")
		local action_layout = require("telescope.actions.layout")
		if not status then
			return
		end

		local keymap = vim.keymap.set
		keymap("n", "<leader>ff", builtin.find_files, { desc = "Telescope Find Files" })
		keymap("n", "<leader>fw", builtin.live_grep, { desc = "Telescope Live Grep" }) -- 环境里要安装ripgrep
		keymap("n", "<leader>fb", builtin.buffers, { desc = "Telescope Find Buffers" })
		keymap("n", "<leader>fh", builtin.help_tags, { desc = "Telescope Help Tags" })
		keymap(
			"n",
			"<leader>fa",
			"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
			{ desc = "Telescope Find all files" }
		)
		keymap("n", "<leader>ft", function()
			require("telescope.builtin").colorscheme({ enable_preview = true, ignore_builtins = true })
		end, { desc = "Telescope find themes" })
		keymap("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
		keymap("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Telescope Git branches" })
		keymap("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Telescope Git commits (repository)" })
		keymap("n", "<leader>gC", "<cmd>Telescope git_bcommits<CR>", { desc = "Telescope Git commits (current file)" })
		keymap("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope Git status" })

		telescope.setup({
			defaults = {
				prompt_prefix = "  ",
				-- selection_caret = " ",
				selection_caret = "▍ ",
				-- selection_caret = "  ",
				layout_config = {
					-- preview_width = 0.6, -- 预览窗口相对于列表窗口的宽度，默认值为 0.5
					preview_cutoff = 100, -- 预览窗口显示的最大行数，默认值为 80
				},
				mappings = {
					n = {
						["q"] = actions.close,
						["l"] = actions.file_edit,
					},
					i = {
						["?"] = action_layout.toggle_preview,
					},
				},
				-- telescope 会根据.gitignore忽略
				-- file_ignore_patterns = {

				-- },
			},
			-- extensions_list = { "themes", "terms" },
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		})
		-- To get fzf loaded and working with telescope, you need to call
		-- load_extension, somewhere after setup function:
		require("telescope").load_extension("fzf")
	end,
}
