-- 自动补全
local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-path",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-cmdline",
			event = "InsertEnter",
		},
		{
			"saadparwaiz1/cmp_luasnip",
			event = "InsertEnter",
		},
		{
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},
		{
			"hrsh7th/cmp-nvim-lsp-signature-help",
			event = "InsertEnter",
		},
		"lukas-reineke/cmp-rg",
	},
	event = "InsertEnter",
}

function M.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets" } }) -- 自定义代码片段
	require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets" } }) -- https://zjp-cn.github.io/neovim0.6-blogs/nvim/luasnip/doc1.html

	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	local source_mapping = {
		buffer = "[Buf]",
		cmdline = "[Cmd]",
		git = "[Git]",
		latex_symbols = "[Latex]",
		luasnip = "[LuaSnip]",
		nvim_lsp = "[LSP]",
		async_path = "[Path]",
		rg = "[Rg]",
		spell = "[Spell]",
		vim_dadbod_completion = "[DB]",
		zsh = "[Zsh]",
	}

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		window = {
			completion = {
				border = "rounded",
				winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentation,Search:None",
			},
			documentation = {
				border = "rounded",
				winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentation,Search:None",
			},
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-e>"] = cmp.mapping.abort(), -- 取消补全，esc也可以退出
			["<CR>"] = cmp.mapping.confirm({ select = false }),

			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		}),

		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "buffer" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "rg" },
		}),
		experimental = {
			ghost_text = true, -- 提示显示第一项全部，灰色显示后半部分
		},

		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.kind = require("lspkind").symbolic(vim_item.kind, { mode = "symbol" }) -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
				vim_item.menu = source_mapping[entry.source.name]
				-- print(vim.inspect(entry:get_completion_item()))
				-- vim_item.menu = entry:get_completion_item().detail
				vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
				return vim_item
			end,
			expandable_indicator = true, -- Boolean to show the `~` expandable indicator in cmp's floating window.
		},

		sorting = {
			-- final_score = orig_score + ((#sources - (source_index - 1)) * sorting.priority_weight)
			priority_weight = 1,
			comparators = {
				cmp.config.compare.exact, -- 精准匹配
				cmp.config.compare.recently_used, -- 最近用过的靠前
				cmp.config.compare.kind,
				cmp.config.compare.score, -- 得分高靠前
				cmp.config.compare.order,
				cmp.config.compare.offset,
				cmp.config.compare.length, -- 短的靠前
				cmp.config.compare.sort_text,
			},
		},
	})
end

return M
