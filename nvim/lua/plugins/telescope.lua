-- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了
return {
	"nvim-telescope/telescope.nvim",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local status, actions = pcall(require, "telescope.actions")
		local action_layout = require("telescope.actions.layout")
		if not status then
			return
		end

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope Find Files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope Live Grep" }) -- 环境里要安装ripgrep
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope Find Buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope Help Tags" })
		vim.keymap.set(
			"n",
			"<leader>fa",
			"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
			{ desc = "Telescope Find all files" }
		)
		vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Telescope Git commits" })
		vim.keymap.set("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope Git status" })

		telescope.setup({
			defaults = {
				prompt_prefix = "  ",
				-- selection_caret = " ",
				selection_caret = "▍ ",
				-- selection_caret = "  ",
				layout_config = {
					preview_width = 0.6, -- 预览窗口相对于列表窗口的宽度，默认值为 0.5
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
		})
	end,
}
