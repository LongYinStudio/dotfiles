-- 默认不开启nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local keymap = vim.keymap.set

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	keymap("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
	keymap("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
	keymap("n", "<C-k>", api.node.show_info_popup, opts("Info"))
	keymap("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
	keymap("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
	keymap("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
	keymap("n", "<C-h>", api.node.open.horizontal, opts("Open: Horizontal Split"))
	keymap("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
	keymap("n", "<CR>", api.node.open.edit, opts("Open"))
	keymap("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
	keymap("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
	keymap("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
	keymap("n", ".", api.node.run.cmd, opts("Run Command"))
	keymap("n", "-", api.tree.change_root_to_parent, opts("Up"))
	keymap("n", "a", api.fs.create, opts("Create File Or Directory"))
	keymap("n", "bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
	keymap("n", "bt", api.marks.bulk.trash, opts("Trash Bookmarked"))
	keymap("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
	keymap("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle Filter: No Buffer"))
	keymap("n", "c", api.fs.copy.node, opts("Copy"))
	keymap("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Filter: Git Clean"))
	keymap("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
	keymap("n", "]c", api.node.navigate.git.next, opts("Next Git"))
	keymap("n", "d", api.fs.remove, opts("Delete"))
	keymap("n", "D", api.fs.trash, opts("Trash"))
	keymap("n", "E", api.tree.expand_all, opts("Expand All"))
	keymap("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
	keymap("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
	keymap("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
	keymap("n", "F", api.live_filter.clear, opts("Live Filter: Clear"))
	keymap("n", "f", api.live_filter.start, opts("Live Filter: Start"))
	keymap("n", "g?", api.tree.toggle_help, opts("Help"))
	keymap("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	keymap("n", "ge", api.fs.copy.basename, opts("Copy Basename"))
	keymap("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
	keymap("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Filter: Git Ignore"))
	keymap("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
	keymap("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
	keymap("n", "L", api.node.open.toggle_group_empty, opts("Toggle Group Empty"))
	keymap("n", "M", api.tree.toggle_no_bookmark_filter, opts("Toggle Filter: No Bookmark"))
	keymap("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
	keymap("n", "o", api.node.open.edit, opts("Open"))
	keymap("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
	keymap("n", "p", api.fs.paste, opts("Paste"))
	keymap("n", "P", api.node.navigate.parent, opts("Parent Directory"))
	keymap("n", "q", api.tree.close, opts("Close"))
	keymap("n", "r", api.fs.rename, opts("Rename"))
	keymap("n", "R", api.tree.reload, opts("Refresh"))
	keymap("n", "s", api.node.run.system, opts("Run System"))
	keymap("n", "S", api.tree.search_node, opts("Search"))
	keymap("n", "u", api.fs.rename_full, opts("Rename: Full Path"))
	keymap("n", "U", api.tree.toggle_custom_filter, opts("Toggle Filter: Hidden"))
	keymap("n", "W", api.tree.collapse_all, opts("Collapse"))
	keymap("n", "x", api.fs.cut, opts("Cut"))
	keymap("n", "y", api.fs.copy.filename, opts("Copy Name"))
	keymap("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
	keymap("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
	keymap("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
end

local function get_system_open_cmd()
	if vim.fn.has("win32") == 1 then
		return "start" -- Windows
	elseif vim.fn.has("mac") == 1 then
		return "open" -- macOS
	elseif vim.fn.has("unix") == 1 then
		-- 检查是否在 WSL 中运行
		local is_wsl = vim.fn.executable("wslpath") == 1
		if is_wsl then
			return "wsl-open" -- 如果是 WSL，使用 wsl-open
		else
			return "xdg-open" -- 普通 Linux 系统
		end
	else
		vim.notify("Unsupported OS", vim.log.levels.WARN)
		return nil
	end
end

-- 文件浏览
return {
	{
		"nvim-tree/nvim-tree.lua", -- 文档树
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- 文档树图标
		},
		keys = {
			{ "<leader>e", ":NvimTreeToggle<CR>", mode = "n", desc = "Nvimtree Toggle window" },
			{ "<leader>f", ":NvimTreeFocus<CR>", mode = "n", desc = "Nvimtree Focus window" },
		},
		config = function()
			require("nvim-tree").setup({
				view = {
					signcolumn = "no",
				},
				on_attach = on_attach,
				-- npm install -g wsl-open
				-- https://github.com/4U6U57/wsl-open/
				-- 没找到默认触发快捷键说明，s 键可以触发
				system_open = {
					-- cmd = "xdg-open", -- linux
					-- cmd = "open", -- mac
					-- cmd = "wsl-open", --wsl
					cmd = get_system_open_cmd(),
				},
				git = { enable = true },
				modified = {
					enable = true,
					show_on_dirs = false,
					show_on_open_dirs = true,
				},
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
						-- signcolumn 列已关
						-- placement: "before", "after", "signcolumn", "right_align"
						git_placement = "right_align", -- 默认: before
						modified_placement = "after",
						hidden_placement = "after",
						diagnostics_placement = "right_align", -- 默认: signcolumn
						bookmarks_placement = "before", -- 默认: signcolumn
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
							modified = true,
							hidden = false,
							diagnostics = true,
							bookmarks = true,
						},
						glyphs = {
							default = "",
							symlink = "",
							bookmark = "󰆤",
							modified = "[+]",
							folder = {
								default = "",
								open = "",
								symlink = "",
								symlink_open = "",
								arrow_open = "",
								arrow_closed = "",
							},
							git = {
								-- 默认
								-- unstaged = "✗",
								-- staged = "✓",
								-- unmerged = "",
								-- renamed = "➜",
								-- untracked = "★",
								-- deleted = "",
								-- ignored = "◌",

								-- Change type
								unstaged = "󰄱",
								staged = "",
								unmerged = "",
								renamed = "󰁕",
								untracked = "",
								deleted = "✖",
								ignored = "",
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
				actions = {
					open_file = {
						-- 首次打开大小适配
						resize_window = true,
						-- 打开文件时关闭 tree
						quit_on_open = false,
					},
				},
			})
		end,
	},
}

-- dark主题下
-- vim.cmd([[
--   highlight NvimTreeLspDiagnosticsError guifg=#c63629
--   highlight NvimTreeLspDiagnosticsWarning guifg=yellow
--
--   highlight NvimTreeGitNew guifg=#81b88b
--   highlight NvimTreeGitDirty guifg=#E2C08D
--   highlight NvimTreeGitDeleted guifg=#c74e39
--   highlight NvimTreeGitRenamed guifg=#73C991
--   highlight NvimTreeGitStaged guifg=#E2C08D
--   highlight NvimTreeGitIgnored guifg=#8C8C8C
--   highlight NvimTreeGitMerge guifg=#e4676b
-- ]])

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
