return {
	"LongYinStudio/suda.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "SudaWrite", "SudaRead", "SudaEdit", "SudoWrite", "SudoRead", "SudoEdit" },
	opts = {},
}
