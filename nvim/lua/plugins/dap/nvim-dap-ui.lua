return {
	"rcarriga/nvim-dap-ui",
	lazy = true,
	dependencies = { "nvim-neotest/nvim-nio" },
	config = function()
		local dapui, keymap = require("dapui"), vim.keymap.set
		keymap({ "n", "t" }, "<leader>du", dapui.toggle, { noremap = true, silent = true, desc = "ToggleDapUI" })

		dapui.setup({
			controls = {
				element = "console", -- repl
				enabled = true,
				icons = {
					play = " 󱊫",
					step_over = " 󱊬",
					step_into = " 󱊭",
					step_out = " 󱊮",
					step_back = " 󱊯",
					run_last = " 󱊰",
					terminate = " 󱊱",
					pause = " 󱊲",
					disconnect = " 󱊳",
				},
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			force_buffers = true,
			icons = {
				collapsed = "",
				current_frame = "",
				expanded = "",
			},
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.25,
						},
						{
							id = "breakpoints",
							size = 0.25,
						},
						{
							id = "stacks",
							size = 0.25,
						},
						{
							id = "watches",
							size = 0.25,
						},
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "console",
							size = 0.5,
						},
					},
					position = "bottom",
					size = 13,
				},
			},
			mappings = {
				edit = "e",
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				repl = "r",
				toggle = "t",
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		})
	end,
}
