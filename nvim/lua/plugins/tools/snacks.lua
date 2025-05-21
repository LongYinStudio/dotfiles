return {
	"folke/snacks.nvim",
	-- enabled = false,
	priority = 1000,
	lazy = false,
	opts = {
		image = {
			enable = true,
			doc = {
				enable = true,
				inline = true,
			},
		},
		bigfile = { enabled = false },
		dashboard = { enabled = false },
		explorer = { enabled = false },
		indent = {
			enabled = true,
			animate = { enabled = true },
			chunk = {
				enabled = true,
				char = {
					-- corner_top = "┌",
					-- corner_bottom = "└",
					corner_top = "╭",
					corner_bottom = "╰",
					horizontal = "─",
					vertical = "│",
					arrow = ">",
				},
			},
		},
		input = { enabled = false },
		notifier = {
			enabled = false,
			timeout = 3000,
		},
		picker = { enabled = true },
		quickfile = { enabled = false },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
	keys = {
		{
			"<leader>fn",
			function()
				Snacks.picker.files()
			end,
			desc = "Snacks picker",
		},
		{
			"<leader>is",
			function()
				Snacks.picker.icons()
			end,
			desc = "Snacks Icons",
		},
		{
			"<leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>n",
			function()
				Snacks.scratch({ icon = " ", name = "Todo", ft = "markdown", file = "~/TODO.md" })
			end,
			desc = "Todo List",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>Ts")
				-- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>Tw")
				-- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>Td")
				-- Snacks.toggle.line_number():map("<leader>Tl")
				-- Snacks.toggle
				-- 	.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
				-- 	:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark/Light" })
					:map("<leader>Tb")
				-- Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>Ti")
				-- Snacks.toggle.dim():map("<leader>uD")
			end,
		})

		-- 没用
		-- -- Snacks + nvim-tree rename
		-- local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
		-- vim.api.nvim_create_autocmd("User", {
		-- 	pattern = "NvimTreeSetup",
		-- 	callback = function()
		-- 		local events = require("nvim-tree.api").events
		-- 		events.subscribe(events.Event.NodeRenamed, function(data)
		-- 			if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
		-- 				data = data
		-- 				Snacks.rename.on_rename_file(data.old_name, data.new_name)
		-- 			end
		-- 		end)
		-- 	end,
		-- })
	end,
}
