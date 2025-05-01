---@alias theme 'bamboo'|'sea'|'peach'|'grape'|'dusk'|'summer'

return {
	"mistricky/codesnap.nvim",
	build = "make",
	cmd = {
		"CodeSnap",
		"CodeSnapSave",
		"CodeSnapASCII",
		"CodeSnapHighlight",
		"CodeSnapSaveHighlight",
	},
	-- 快捷键，不知道为什么要等很久才有反应
	-- keys = {
	-- 	{ "<leader>cC", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
	-- 	{
	-- 		"<leader>cS",
	-- 		"<cmd>CodeSnapSave<cr>",
	-- 		mode = "x",
	-- 		desc = "Save selected code snapshot in ~/Pictures",
	-- 	},
	-- },
	opts = {
		mac_window_bar = true,
		title = "CodeSnap.nvim",
		code_font_family = "JetBrainsMono Nerd Font",
		watermark_font_family = "Pacifico", -- 默认值
		watermark = "CodeSnap.nvim",
		---@type theme
		bg_theme = "bamboo", -- default:"default"
		breadcrumbs_separator = "/",
		has_breadcrumbs = true,
		has_line_number = true,
		show_workspace = false,
		min_width = 0,
		-- bg_x_padding = 26,
		-- bg_y_padding = 80,
		-- bg_padding = 20,
		-- save_path = os.getenv("XDG_PICTURES_DIR") or (os.getenv("HOME").. "/Pictures")
		save_path = "~/Pictures",
	},
}

-- TODO: 解决watermark不显示
