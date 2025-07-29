return {
	"VidocqH/lsp-lens.nvim", -- 显示definition/references/implements
	enabled = false, -- 由 Wansmer/symbol-usage.nvim 替代
	config = function()
		require("lsp-lens").setup({
			enable = true,
			include_declaration = true, -- Reference include declaration
			sections = { -- Enable / Disable specific request
				definition = true,
				references = true,
				implements = true,
			},
			ignore_filetype = {
				"prisma",
			},
		})
	end,
}
