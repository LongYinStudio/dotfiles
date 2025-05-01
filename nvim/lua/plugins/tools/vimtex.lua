return {
	-- https://ctan.org/tex-archive/support/latexmk/latexmk.pl
	"lervag/vimtex",
	enabled = false,
	ft = { "tex" },
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		-- vim.g.vimtex_view_general_viewer = "okular"
		-- vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
		-- vim.g.vimtex_compiler_method = "latexmk"
	end,
}
