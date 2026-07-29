return {
	"mistricky/codesnap.nvim",
	tag = "v2.1.0",
	cmd = {
		"CodeSnap",
		"CodeSnapSave",
		"CodeSnapASCII",
		"CodeSnapHighlight",
	},
	keys = {
		{ "<leader>cC", "<cmd>CodeSnap<cr>", mode = "x", desc = "代码截图到剪贴板" },
		{
			"<leader>cS",
			mode = "x",
			desc = "代码截图保存到 ~/Pictures/CodeSnap",
			function()
				local dir = vim.fn.expand("~/Pictures/CodeSnap")
				vim.fn.mkdir(dir, "p")
				require("codesnap").save(("%s/%s.png"):format(dir, os.date("%Y-%m-%d_%H%M%S")))
			end,
		},
	},
	opts = {
		show_line_number = true,
		show_workspace = false,
		snapshot_config = {
			window = {
				mac_window_bar = false,
				title_config = {
					color = "#A5ADCB",
					font_family = "Maple Mono",
				},
				shadow = {
					radius = 28,
					color = "#0A0C14A0",
				},
				margin = { x = 10, y = 10 },
				border = {
					width = 1,
					color = "#FFFFFF24",
				},
				radius = 14,
			},
			line_number_color = "#737994",
			code_config = {
				font_family = "Maple Mono",
				breadcrumbs = {
					enable = false,
					separator = " › ",
					color = "#838BA7",
					font_family = "Maple Mono",
				},
			},
			watermark = {
				content = "@longyinstudio",
				font_family = "Maple Mono",
				color = "#B7BDF88C",
			},
			background = {
				start = { x = 0, y = 0 },
				["end"] = { x = "max", y = "max" },
				stops = {
					{ position = 0, color = "#D0DDE9" },
					{ position = 1, color = "#F2F7FA" },
				},
			},
		},
	},
}
