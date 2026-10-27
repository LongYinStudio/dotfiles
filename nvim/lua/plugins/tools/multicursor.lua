-- 多光标[ctrl+n，(neo)vim自带的*就够用了]
return {
	{
		"mg979/vim-visual-multi",
		branch = "master",
		init = function()
			vim.g.VM_silent_exit = 1
			vim.g.VM_show_warnings = 0
			vim.g.VM_verbose_commands = 1
			vim.g.VM_theme = "codedark"
			vim.g.VM_set_statusline = 3

			vim.g.VM_default_mappings = 0
			-- available keymap
			vim.api.nvim_set_keymap("n", "<C-n>", "<Plug>(VM-Find-Under)", {})
			vim.api.nvim_set_keymap("x", "<C-n>", "<Plug>(VM-Find-Subword-Under)", {})
			vim.api.nvim_set_keymap("n", "<C-S-Up>", "<Plug>(VM-Add-Cursor-Up)", { desc = "add multi cursor up" })
			vim.api.nvim_set_keymap("n", "<C-S-Down>", "<Plug>(VM-Add-Cursor-Down)", { desc = "add multi cursor down" })
			-- advance keymap
			-- vim.api.nvim_set_keymap("n", "<C-S-Down>", "<Plug>(VM-Select-Next)", {})
			-- vim.api.nvim_set_keymap("n", "<C-S-Up>", "<Plug>(VM-Select-Prev)", {})
			-- vim.api.nvim_set_keymap("n", "<C-d>", "<Plug>(VM-Remove-Cursor)", {})
			-- vim.api.nvim_set_keymap("n", "<C-S-d>", "<Plug>(VM-Remove-All)", {})
			-- vim.api.nvim_set_keymap("n", "<C-l>", "<Plug>(VM-Reselect-Last)", {})
			-- vim.api.nvim_set_keymap("n", "<C-a>", "<Plug>(VM-Select-All)", {})
			-- vim.api.nvim_set_keymap("n", "<C-/>", "<Plug>(VM-Visual-Clear)", {})
			-- vim.api.nvim_set_keymap("n", "<C-Space>", "<Plug>(VM-Visual-Regex)", {})
			-- -- switch between cursors
			-- vim.api.nvim_set_keymap("n", "n", "<Plug>(VM-Find-Under)", {})
			-- vim.api.nvim_set_keymap("n", "N", "<Plug>(VM-Select-Next)", {})
			-- vim.api.nvim_set_keymap("n", "p", "<Plug>(VM-Select-Prev)", {})
			-- -- lock and unclock the current cursor
			-- vim.api.nvim_set_keymap("n", "<C-s>", "<Plug>(VM-Insert)", {})
			-- vim.api.nvim_set_keymap("n", "<C-r>", "<Plug>(VM-Replace)", {})
		end,
	},
	{
		"jake-stewart/multicursor.nvim",
		enabled = false,
		branch = "1.0",
		config = function()
			local mc = require("multicursor-nvim")
			mc.setup()

			local set = vim.keymap.set

			-- Add or skip cursor above/below the main cursor.
			set({ "n", "x" }, "<up>", function()
				mc.lineAddCursor(-1)
			end)
			set({ "n", "x" }, "<down>", function()
				mc.lineAddCursor(1)
			end)
			set({ "n", "x" }, "<leader><up>", function()
				mc.lineSkipCursor(-1)
			end)
			set({ "n", "x" }, "<leader><down>", function()
				mc.lineSkipCursor(1)
			end)

			-- Add or skip adding a new cursor by matching word/selection
			set({ "n", "x" }, "<leader>n", function()
				mc.matchAddCursor(1)
			end)
			set({ "n", "x" }, "<leader>s", function()
				mc.matchSkipCursor(1)
			end)
			set({ "n", "x" }, "<leader>N", function()
				mc.matchAddCursor(-1)
			end)
			set({ "n", "x" }, "<leader>S", function()
				mc.matchSkipCursor(-1)
			end)

			-- Add and remove cursors with control + left click.
			set("n", "<c-leftmouse>", mc.handleMouse)
			set("n", "<c-leftdrag>", mc.handleMouseDrag)
			set("n", "<c-leftrelease>", mc.handleMouseRelease)

			-- Disable and enable cursors.
			set({ "n", "x" }, "<c-q>", mc.toggleCursor)

			-- Mappings defined in a keymap layer only apply when there are
			-- multiple cursors. This lets you have overlapping mappings.
			mc.addKeymapLayer(function(layerSet)
				-- Select a different cursor as the main one.
				layerSet({ "n", "x" }, "<left>", mc.prevCursor)
				layerSet({ "n", "x" }, "<right>", mc.nextCursor)

				-- Delete the main cursor.
				layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

				-- Enable and clear cursors using escape.
				layerSet("n", "<esc>", function()
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					else
						mc.clearCursors()
					end
				end)
			end)

			-- Customize how cursors look.
			local hl = vim.api.nvim_set_hl
			hl(0, "MultiCursorCursor", { reverse = true })
			hl(0, "MultiCursorVisual", { link = "Visual" })
			hl(0, "MultiCursorSign", { link = "SignColumn" })
			hl(0, "MultiCursorMatchPreview", { link = "Search" })
			hl(0, "MultiCursorDisabledCursor", { reverse = true })
			hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
			hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
		end,
	},
}
