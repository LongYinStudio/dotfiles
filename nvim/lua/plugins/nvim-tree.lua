-- 默认不开启nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- dark主题下
vim.cmd([[
  highlight NvimTreeLspDiagnosticsError guifg=#c63629
  highlight NvimTreeLspDiagnosticsWarning guifg=yellow

  highlight NvimTreeGitNew guifg=#81b88b
  highlight NvimTreeGitDirty guifg=#E2C08D
  highlight NvimTreeGitDeleted guifg=#c74e39
  highlight NvimTreeGitRenamed guifg=#73C991
  highlight NvimTreeGitStaged guifg=#E2C08D
  highlight NvimTreeGitIgnored guifg=#8C8C8C
  highlight NvimTreeGitMerge guifg=#e4676b
]])

-- light主题下
-- vim.cmd([[
--   highlight NvimTreeLspDiagnosticsError guifg=#c63629
--   highlight NvimTreeLspDiagnosticsWarning guifg=yellow
--
--   highlight NvimTreeGitNew guifg=#587c0c
--   highlight NvimTreeGitDirty guifg=#895503
--   highlight NvimTreeGitDeleted guifg=#ad0707
--   highlight NvimTreeGitRenamed guifg=#007100
--   highlight NvimTreeGitStaged guifg=#895503
--   highlight NvimTreeGitIgnored guifg=#ad0707
--   highlight NvimTreeGitMerge guifg=#e4676b
-- ]])

return {
	{
		"nvim-tree/nvim-tree.lua", -- 文档树
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- 文档树图标
		},
		config = function()
			vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>f", "<cmd>NvimTreeFocus<CR>", { noremap = true, silent = true })
			require("nvim-tree").setup({
				git = { enable = true },
				-- 完全禁止内置netrw
				disable_netrw = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
				sort_by = "case_sensitive",
				renderer = {
					root_folder_label = false, -- 隐藏当前根目录地址显示
					highlight_git = true,
					highlight_opened_files = "none",
					indent_markers = {
						enable = true,
					},
					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = false,
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
					git_ignored = false,
					-- 隐藏 node_modules 文件夹
					custom = { "node_modules" },
				},
				diagnostics = {
					enable = true,
					icons = {
						hint = "",
						info = "",
						warning = "",
						error = "",
					},
				},
			})
		end,
	},
}
