-- 快捷键提示
return {
	{
		-- TODO: 试试 which key 新出的 hydra 特性 Hydra Mode: keep the popup open until you hit <esc>
		-- 比方说你映射 leader db 下断点， leader ds 单步，有了 hydra 之后，你按下 leader d 会进入调试模式，
		-- 然后只按 b 就能下断点，只按 s 就能步进，不用再按 leader d 这个前缀 常见的还有 ctrl-w 窗口模式
		-- hydra.nvim 是一个插件，你可以在插件的 wiki 里看到更多示例 不过作者好像上战场了，很久没更新了
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Local Keymaps",
			},
		},
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts_extend = { "spec" },
		opts = {
			defaults = {},
			win = {
				-- don't allow the popup to overlap with the cursor
				no_overlap = true,
				border = "rounded",
				-- padding = { 1, 1 }, -- extra window padding [top/bottom, right/left]
				title = "Keybindings",
				title_pos = "center",
			},
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader>`", group = "ToggleTerm", icon = { icon = " " } },
					{ "<leader>a", group = "Neogen", icon = { icon = " " } },
					{ "<leader>b", group = "Buffer", icon = { icon = "󰓩 " } }, -- 
					{ "<leader>c", group = "Code", icon = { icon = "󱃖 " } },
					{ "<leader>d", group = "Debug", icon = { icon = " " } },
					{ "<leader>f", group = "Find", icon = { icon = "󰈞 " } }, -- 
					{ "<leader>g", group = "Git", icon = { icon = " " } }, --   
					{ "<leader>h", group = "Sidekick(AI)", icon = { icon = " " } },
					{ "<leader>i", group = "Icon", icon = { icon = "󰥷 " } },
					{ "<leader>r", group = "Rest", icon = { icon = " ", color = "blue" } },
					{ "<leader>s", group = "search/replace", icon = "󰛔 " }, --     
					{ "<leader>t", group = "ToggleTerm", icon = { icon = " " } },
					{ "<leader>T", group = "Toggle", icon = { icon = "  " } },
					{ "<leader>u", group = "URL", icon = { icon = "󰌷 ", color = "cyan" } },
					{ "<leader>w", group = "Window", icon = { icon = " ", color = "blue" } },
					{ "<leader>wv", icon = { icon = " ", color = "blue" } },
					{ "<leader>wh", icon = { icon = " ", color = "blue" } },
					{ "<leader>x", group = "Diagnostics/Quickfix", icon = { icon = "󱖫 ", color = "green" } },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gs", group = "surround" },
					{ "z", group = "fold" },
					-- better descriptions
					-- { "gx", desc = "Open with system app" },
					{ "K", desc = "Documentation", icon = " " },
					{ "<leader>cr", desc = "Rename", icon = { icon = "󰑕 ", color = "purple" } },
					{ "<leader>L", "<cmd>Lazy<CR>", desc = "Lazy", icon = "󰒲 " },
					{ "<leader>M", "<cmd>Mason<CR>", desc = "Mason", icon = " " },
				},
			},
			icons = {
				-- 加入新rules，不会覆盖插件自带的 (pattern用小写)
				rules = {
					{ pattern = "window", icon = "", color = "blue" },
					{ pattern = "nvimtree", icon = "" },
					{ pattern = "indent right", icon = "󰔰 ", hl = "Function" },
					{ pattern = "indent left", icon = "󰶢 ", hl = "Function" },
					{ pattern = "no highlight search", icon = "󰹏 ", color = "Yellow" },
					{ pattern = "keymap", icon = " " },
					{ pattern = "lazygit", icon = " " },
					{ pattern = "toggleterm", icon = " " },
					{ pattern = "delete", icon = "✘ " },
					{ pattern = "telescope", icon = " " },
					{ pattern = "rest", icon = " ", color = "blue" },
				},
			},
		},
	},
}
