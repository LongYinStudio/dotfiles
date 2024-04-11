-- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.1", -- 文件检索
	dependencies = { { "nvim-lua/plenary.nvim" } },
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local status, actions = pcall(require, "telescope.actions")
		local action_layout = require("telescope.actions.layout")
		if not status then
			return
		end

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {}) -- 环境里要安装ripgrep
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

		telescope.setup({
			defaults = {
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
				file_ignore_patterns = {
					"node_modules",
					".git",
				},
			},
		})
	end,
}
