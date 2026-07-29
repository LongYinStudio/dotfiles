-- 自动补全标签
return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	opts = {}, -- lazy.nvim 会调用 require("nvim-ts-autotag").setup({})
	-- 需要单独覆盖某项时（默认全部开启）：
	-- opts = {
	-- 	opts = {
	-- 		enable_close = true, -- Auto close tags
	-- 		enable_rename = true, -- Auto rename pairs of tags
	-- 		enable_close_on_slash = true, -- Auto close on trailing </
	-- 	},
	-- 	per_filetype = {
	-- 		["html"] = { enable_close = false },
	-- 	},
	-- },
}
