-- 在进入普通模式时自动保存文件
vim.cmd([[
autocmd InsertLeave * silent! write
]])
local api = vim.api
-- Enable spell checking for certain file types
api.nvim_create_autocmd(
	{ "BufRead", "BufNewFile" },
	-- { pattern = { "*.txt", "*.md", "*.tex" }, command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]] }
	{
		pattern = { "*.txt", "*.md", "*.tex" },
		callback = function()
			vim.opt.spell = true
		end,
	}
)
-- 用o换行不要延续注释
api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		-- O and o, don't continue comments
		vim.opt.formatoptions:remove("o")
		-- But do continue when pressing enter.
		vim.opt.formatoptions:append("r")
	end,
})
