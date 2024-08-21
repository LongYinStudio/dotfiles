-- linux下fcitx5输入法自动切换中英文
return {
	"h-hg/fcitx.nvim",
	enabled = function()
		return vim.fn.executable("fcitx5-remote") == 1
	end,
	event = { "InsertEnter" },
}
