-- Git 差异对比与历史查看
return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewRefresh",
		"DiffviewFileHistory",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<leader>gv",
			function()
				if next(require("diffview.lib").views) == nil then
					vim.cmd("DiffviewOpen")
				else
					vim.cmd("DiffviewClose")
				end
			end,
			desc = "Diffview Toggle",
		},
		{
			"<leader>gh",
			"<cmd>DiffviewFileHistory %<cr>",
			desc = "Diffview Current File History",
		},
		{
			"<leader>gH",
			"<cmd>DiffviewFileHistory<cr>",
			desc = "Diffview Branch History",
		},
	},
	opts = {
		diff_binaries = false,
		enhanced_diff_hl = true,
		use_icons = true,
		show_help_hints = true,
		view = {
			default = {
				layout = "diff2_horizontal",
				winbar_info = true,
			},
			merge_tool = {
				layout = "diff3_horizontal",
				disable_diagnostics = true,
				winbar_info = true,
			},
			file_history = {
				layout = "diff2_horizontal",
				winbar_info = true,
			},
		},
		file_panel = {
			listing_style = "tree", -- 'list' | 'tree'
			tree_options = {
				flatten_dirs = true,
				folder_statuses = "only_folded",
			},
			win_config = {
				position = "left",
				width = 35,
			},
		},
		file_history_panel = {
			win_config = {
				position = "bottom",
				height = 16,
			},
		},
		default_args = {
			DiffviewOpen = {},
			DiffviewFileHistory = {},
		},
		hooks = {
			diff_buf_read = function(_)
				vim.opt_local.wrap = false
			end,
		},
	},
}
