local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
		{ import = "plugins/ui" },
		{ import = "plugins/editor" },
		{ import = "plugins/lsp" },
		{ import = "plugins/tools" },
		{ import = "plugins/git" },
		{ import = "plugins/completion" },
	},
	-- colorscheme that will be used when installing plugins.
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		-- colorscheme = { "onedark" },
	},
	-- automatically check for plugin updates
	checker = { enabled = false },
	ui = {
		border = "rounded",
		title = "Plugin Manager",
		title_pos = "center",
	},
})
