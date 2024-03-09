-- 默认不开启nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	git = { enable = true }, --显示git状态
	-- 完全禁止内置netrw
	disable_netrw = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	sort_by = "case_sensitive",
	renderer = {
		root_folder_label = false, -- 隐藏当前根目录地址显示
		highlight_git = false,
		highlight_opened_files = "none",
		indent_markers = {
			enable = true,
		},
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				folder = {
					default = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
			},
		},
	},
	filters = {
		-- 隐藏 .文件(H进行切换)
		dotfiles = false,
		-- 隐藏 node_modules 文件夹
		custom = { "node_modules" },
	},
})
