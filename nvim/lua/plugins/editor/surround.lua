---@type LazySpec
return {
	"kylechui/nvim-surround",
	keys = {
		{ "ys", mode = "n" },
		{ "yS", mode = "n" },
		{ "ds", mode = "n" },
		{ "cs", mode = "n" },
		{ "S", mode = "x" },
	},
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	config = function()
		require("nvim-surround").setup({})
	end,
}

-- 用法
--     Old text                    Command         New text
-- --------------------------------------------------------------------------------
--     surr*ound_words             ysiw)           (surround_words)
--     *make strings               ys$"            "make strings"
--     [delete ar*ound me!]        ds]             delete around me!
--     remove <b>HTML t*ags</b>    dst             remove HTML tags
--     'change quot*es'            cs'"            "change quotes"
--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
--     delete(functi*on calls)     dsf             function calls
