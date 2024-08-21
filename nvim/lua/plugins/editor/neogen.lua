-- 快捷生成 class、function 等等注释
return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		-- 	func, class, type, file
		require("neogen").setup({ snippet_engine = "luasnip" })
		vim.keymap.set("n", "<leader>an", ":Neogen<CR>", {
			noremap = true,
			silent = true,
			desc = "Generate annotation [Neogen]",
		})
		vim.keymap.set("n", "<leader>af", ":Neogen func<CR>", {
			noremap = true,
			silent = true,
			desc = "Annotate function [Neogen]",
		})
		vim.keymap.set("n", "<leader>ac", ":Neogen class<CR>", {
			noremap = true,
			silent = true,
			desc = "Annotate class [Neogen]",
		})
		vim.keymap.set("n", "<leader>at", ":Neogen type<CR>", {
			noremap = true,
			silent = true,
			desc = "Annotate type [Neogen]",
		})
		vim.keymap.set("n", "<leader>aa", ":Neogen file<CR>", {
			noremap = true,
			silent = true,
			desc = "Annotate file [Neogen]",
		})
	end,
}
