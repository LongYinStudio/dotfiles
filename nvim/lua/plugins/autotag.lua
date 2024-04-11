return {
	{
		"windwp/nvim-ts-autotag",
		config = function()
			local status_ok, nvim_ts_autotag = pcall(require, "nvim-ts-autotag")
			if not status_ok then
				vim.notify("nvim-ts-autotag not found!", "warn")
				return
			end

			nvim_ts_autotag.setup()
		end,
	},
}
