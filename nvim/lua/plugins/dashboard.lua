return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
	opts = function()
		local logo = [[
    ███╗  ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗ ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚████║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚███║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

		logo = string.rep("\n", 4) .. logo .. "\n\n"

		local opts = {
			theme = "doom",
			hide = {
				statusline = false,
			},
			config = {
				header = vim.split(logo, "\n"),
				center = {
					{
						action = "Telescope find_files",
						desc = " Find file",
						desc_hl = "Number",
						icon = " ",
						icon_hl = "Number",
						key = "f",
						key_format = " %s",
						key_hl = "Number",
					},
					{
						action = "ene | startinsert",
						desc = " New file",
						desc_hl = "Number",
						icon = " ",
						icon_hl = "Number",
						key = "n",
						key_format = " %s",
						key_hl = "Number",
					},
					{
						action = "Telescope oldfiles",
						desc = " Recent files",
						desc_hl = "Number",
						icon = " ",
						icon_hl = "Number",
						key = "r",
						key_format = " %s",
						key_hl = "Number",
					},
					{
						action = "Telescope live_grep",
						desc = " Find Text",
						desc_hl = "Number",
						icon = " ",
						icon_hl = "Number",
						key = "g",
						key_format = " %s",
						key_hl = "Number",
					},
					{
						action = "Lazy",
						desc = " Lazy",
						desc_hl = "String",
						icon = "󰒲 ",
						icon_hl = "String",
						key = "l",
						key_format = " %s",
						key_hl = "String",
					},
					{
						action = "Mason",
						desc = " Mason (Manage LSP / Linters)",
						desc_hl = "String",
						icon = " ",
						icon_hl = "String",
						key = "m",
						key_format = " %s",
						key_hl = "String",
					},
					{
						action = "e $MYVIMRC",
						desc = " Config",
						desc_hl = "Title",
						icon = " ",
						icon_hl = "Title",
						key = "c",
						key_format = " %s",
						key_hl = "Title",
					},
					{
						action = "qa",
						desc = " Quit",
						desc_hl = "Error",
						icon = " ",
						icon_hl = "Error",
						key = "q",
						key_format = " %s",
						key_hl = "Error",
					},
					-- {
					-- 	action = 'lua require("persistence").load()',
					-- 	desc = " Restore Session",
					-- 	icon = " ",
					-- 	key = "s",
					-- },
					-- {
					-- 	desc = " Git Status",
					-- 	group = "DiagnosticHint",
					-- 	action = "Telescope git_status",
					-- 	key = "s",
					-- },
					-- {
					-- 	desc = " Git Commits",
					-- 	group = "Number",
					-- 	action = "Telescope git_commits",
					-- 	key = "c",
					-- },
					-- { action = "LazyGit", desc = "LazyGit ", key = "g", icon = " " },
				},
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
		end

		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DashboardLoaded",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		return opts
	end,
}
