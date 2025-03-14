-- 修改拼写下划线的样式
vim.api.nvim_set_hl(0, "SpellBad", { fg = "#e86671", underline = true, sp = "#e86671" })
vim.api.nvim_set_hl(0, "SpellCap", { fg = "#e5c07b", underline = true, sp = "#e5c07b" })
vim.api.nvim_set_hl(0, "SpellLocal", { fg = "#61afef", underline = true, sp = "#61afef" })
vim.api.nvim_set_hl(0, "SpellRare", { fg = "#c678dd", underline = true, sp = "#c678dd" })

vim.api.nvim_set_hl(0, "LineNr", { fg = "#808080" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#808080" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#808080" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#48f3db" }) -- #ff9e64
