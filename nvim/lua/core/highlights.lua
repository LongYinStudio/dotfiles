local function hl(theme)
	for k, v in pairs(theme) do
		vim.api.nvim_set_hl(0, k, v)
	end
end

hl({
	-- 修改拼写检查的样式
	SpellBad = { fg = "#e86671", underline = true, sp = "#e86671" },
	SpellCap = { fg = "#e5c07b", underline = true, sp = "#e5c07b" },
	SpellLocal = { fg = "#61afef", underline = true, sp = "#61afef" },
	SpellRare = { fg = "#c678dd", underline = true, sp = "#c678dd" },

	LineNr = { fg = "#808080" },
	LineNrAbove = { fg = "#808080" },
	LineNrBelow = { fg = "#808080" },
	CursorLineNr = { fg = "#48f3db" }, -- #ff9e64

	-- ["@keyword.operator"] = { fg = "#ff0000" },
})
