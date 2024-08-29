return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.opt.termguicolors = true

		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "NvimTree",
						-- filetype = "neo-tree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		})

		---@param buf number?
		local bufremove = function(buf)
			buf = buf or 0
			buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

			if vim.bo.modified then
				local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
				if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
					return
				end
				if choice == 1 then -- Yes
					vim.cmd.write()
				end
			end

			for _, win in ipairs(vim.fn.win_findbuf(buf)) do
				vim.api.nvim_win_call(win, function()
					if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
						return
					end
					-- Try using alternate buffer
					local alt = vim.fn.bufnr("#")
					if alt ~= buf and vim.fn.buflisted(alt) == 1 then
						vim.api.nvim_win_set_buf(win, alt)
						return
					end

					-- Try using previous buffer
					local has_previous = pcall(vim.cmd, "bprevious")
					if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
						return
					end

					-- Create new listed buffer
					local new_buf = vim.api.nvim_create_buf(true, false)
					vim.api.nvim_win_set_buf(win, new_buf)
				end)
			end
			if vim.api.nvim_buf_is_valid(buf) then
				pcall(vim.cmd, "bdelete! " .. buf)
			end
		end

		local nmap = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
		end

		nmap("H", "<cmd>BufferLineCyclePrev<CR>", "Prev Buffer")
		nmap("L", "<cmd>BufferLineCycleNext<CR>", "Next Buffer")
		nmap("[b", "<cmd>BufferLineCyclePrev<CR>", "Prev Buffer")
		nmap("]b", "<cmd>BufferLineCycleNext<CR>", "Next Buffer")
		nmap("[B", "<cmd>BufferLineMovePrev<CR>", "Move buffer prev")
		nmap("]B", "<cmd>BufferLineMoveNext<CR>", "Move buffer next")
		nmap("<leader>bc", bufremove, "Close current buffer")
		nmap("<leader>bC", "<cmd>bd<CR>", "Close current buffer and window")
		nmap("<leader>bl", "<cmd>BufferLineCloseRight<CR>", "Close buffers on the right")
		nmap("<leader>bh", "<cmd>BufferLineCloseLeft<CR>", "Close buffers on the left")
		nmap("<leader>bo", "<cmd>BufferLineCloseOthers<CR>", "Close other buffers")
		nmap("<leader>bt", "<cmd>BufferLinePick<CR>", "Go to buffer (Pick)")
		nmap("<leader>be", "<cmd>BufferLinePickClose<CR>", "Close buffer (Pick)")
		nmap("<leader>bp", "<cmd>BufferLineTogglePin<CR>", "Toggle Pin")
		nmap("<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", "Delete Non-Pinned Buffers")
	end,
}
