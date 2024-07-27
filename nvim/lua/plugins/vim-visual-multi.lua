-- 多光标[ctrl+n，(neo)vim自带的*就够用了]
return {
	"mg979/vim-visual-multi",
	branch = "master",
	config = function()
		vim.g.VM_silent_exit = 1
		vim.g.VM_show_warnings = 0
		vim.g.VM_verbose_commands = 1
		vim.g.VM_theme = "codedark"
		vim.g.VM_set_statusline = 3
	end,
}
