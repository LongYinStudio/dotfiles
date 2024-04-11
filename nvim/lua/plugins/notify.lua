return {
	{
		"rcarriga/nvim-notify", -- 消息提醒
		init = function()
			vim.notify = require("notify")
		end,
	},
}
