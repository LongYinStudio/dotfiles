return {
	{
		"nvim-lualine/lualine.nvim", -- 状态栏
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true }, -- 状态栏图标
		config = function()
			require("lualine").setup({
				options = {
					theme = "onedark",
					component_separators = {
						left = "|",
						right = "|",
					},
					-- https://github.com/ryanoasis/powerline-extra-symbols
					section_separators = {
						left = " ",
						right = "",
					},
					globalstatus = true,
				},
				extensions = { "nvim-tree" },
				sections = {
					lualine_c = {
						"filename",
						{
							"lsp_progress",
							spinner_symbols = { " ", " ", " ", " ", " ", " " },
						},
					},
					lualine_x = {
						"filesize",
						{
							"fileformat",
							symbols = {
								unix = "", -- e712
								dos = "", -- e70f
								mac = "", -- e711
							},
							-- symbols = {
							-- 	unix = "LF",
							-- 	dos = "CRLF",
							-- 	mac = "CR",
							-- },
						},
						"encoding",
						"filetype",
					},
				},
			})
		end,
	},
}
