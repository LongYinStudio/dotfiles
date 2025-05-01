local icons = {
	SemiCircleLeft = "",
	SemiCircleRight = "",
	Formatter = "󰉢",
	LSP = " ",
	FileSize = "",
	Location = "",
	Left = " ",
	Right = "",
	Branch = "",
	File = "",
	diagnostics = {
		Error = "",
		Warning = "",
		Hint = "󰌵",
		Info = "",
	},
}

local get_lsp_str = function()
	local lsps = {}
	for _, lsp in ipairs(vim.lsp.get_clients()) do
		table.insert(lsps, lsp.name)
	end
	return icons.LSP .. "[" .. table.concat(lsps, ", ") .. "]"
end

return {
	{
		"nvim-lualine/lualine.nvim", -- 状态栏
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true }, -- 状态栏图标
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					component_separators = {
						left = "|",
						right = "|",
					},
					disabled_filetypes = { "alpha", "dashboard", "Outline" },
					always_divide_middle = true,
				},
				extensions = { "nvim-tree" },
				sections = {
					lualine_a = {
						"mode",
					},
					lualine_b = {
						{ "filename", icon = icons.File },
						{ "branch", icon = icons.Branch },
					},
					lualine_c = {
						{
							"diagnostics",
							sources = {
								-- "nvim_diagnostic",
								"nvim_lsp",
							},
							sections = {
								"info",
								"error",
								"warn",
								"hint",
							},
							diagnostic_color = {
								error = { fg = "DiaganosticError" },
								warn = { fg = "DiagnosticWarn" },
								info = { fg = "DiaganosticInfo" },
								hint = { fg = "DiaganosticHint" },
							},
							colored = true,
							update_in_insert = true,
							always_visible = true,
							symbols = icons.diagnostic,
						},
						{
							"diff",
							symbols = { added = " ", modified = " ", removed = " " },
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},
					lualine_x = {
						{ get_lsp_str },
						--  lualine 自带的只能显示buf attached的
						{
							"lsp_status",
							icon = "", -- f013
							symbols = {
								-- Standard unicode symbols to cycle through for LSP progress:
								spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
								-- Standard unicode symbol for when LSP is done:
								done = "✓",
								-- Delimiter inserted between LSP names:
								separator = ", ",
							},
							-- List of LSP names to ignore (e.g., `null-ls`):
							ignore_lsp = {},
						},
						{
							"fileformat",
							symbols = {
								unix = " - LF", -- e712
								dos = " - CRLF", -- e70f
								mac = " - CR", -- e711
							},
							separator = { left = icons.SemiCircleLeft, right = icons.SemiCircleRight },
							color = { bg = "#B4BEFE", fg = "#eeeeee", gui = "bold" },
						},
						{
							"filesize",
							icon = icons.FileSize,
						},
					},
					lualine_y = { "filetype", "encoding" },
					lualine_z = {
						"progress",
						{
							"location",
							icon = icons.Location,
							color = { gui = "bold" },
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
}
