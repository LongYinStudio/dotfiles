return {
	"xiyaowong/transparent.nvim",
	enabled = false,
	init = function()
		require("which-key").add({
			"<leader>Tt",
			function()
				local state = vim.g.transparent_enabled or false

				vim.cmd(state and [[ TransparentDisable ]] or [[ TransparentEnable ]])
				vim.g.transparent_enabled = not state
			end,
			icon = function()
				local state = vim.g.transparent_enabled
				return { icon = state and " " or " ", color = state and "green" or "yellow" }
			end,
			desc = function()
				return vim.g.transparent_enabled and "Disable Transparency" or "Enable Transparency"
			end,
		})
	end,
}
