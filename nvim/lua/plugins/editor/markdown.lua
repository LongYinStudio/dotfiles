return {
	{
		"iamcco/markdown-preview.nvim", -- 类似的 https://github.com/toppair/peek.nvim
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && yarn install",
		-- 	config = function()
		-- 		-- vim.g.mkdp_browser = "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
		-- 		-- vim.g.mkdp_browser = "/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
		-- 		vim.g.mkdp_auto_close = 1
		-- 	end,
	},
	{
		"MeanderingProgrammer/markdown.nvim", -- 类似的https://github.com/OXY2DEV/markview.nvim
		main = "render-markdown",
		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		-- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		ft = { "markdown" },
		opts = {
			heading = {
				-- default:
				-- signs = { "󰫎 " },
				-- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },

				-- icons = { "󰫎 " },
				icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
				signs = { "#1", "#2", "#3", "#4", "#5", "#6" },
				-- signs = { "━ " },
			},
			pipe_table = {
				border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
			},
		},
	},
	{
		"Zeioth/markmap.nvim",
		enabled = function()
			return vim.fn.executable("markmap") == 1
		end,
		-- build = "npm install markmap-cli -g", -- install_dep.sh里安装
		cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
		ft = { "markdown" },
		opts = {
			html_output = "/tmp/markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
			hide_toolbar = false, -- (default)
			grace_period = 3600000, -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
		},
		config = function(_, opts)
			require("markmap").setup(opts)
		end,
	},
}
