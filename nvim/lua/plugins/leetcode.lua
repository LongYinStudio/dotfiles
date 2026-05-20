return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
	dependencies = {
		-- include a picker of your choice, see picker section for more details
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim",
	},
	opts = {
		lang = "typescript",
		cn = { -- leetcode.cn
			enabled = true, ---@type boolean
			translator = true, ---@type boolean
			translate_problems = true, ---@type boolean
		},
		---@type boolean
		-- image_support = true,
	},
}
