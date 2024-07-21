return {
	"onsails/lspkind.nvim",
	config = function()
		require("lspkind").init({
			-- defines how annotations are shown
			-- default: symbol
			-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
			mode = "symbol_text",

			-- default symbol map
			-- can be either 'default' (requires nerd-fonts font) or
			-- 'codicons' for codicon preset (requires vscode-codicons font)
			--
			-- default: 'default'
			preset = "default", --"codicons",

			-- override preset symbols
			symbol_map = {
				Array = "󰅪 ", --  󰅪 󰅨 󱃶
				Boolean = "󰨙 ", --  ◩ 󰔡 󱃙 󰟡 󰨙
				Class = "󰠱 ", --  󰌗 󰠱 𝓒
				Codeium = "󰘦 ", -- 󰘦
				Collapsed = " ", -- 
				Color = "󰏘 ", -- 󰸌 󰏘
				Constant = "󰏿 ", --   󰏿
				Constructor = " ", --  󰆧   
				Control = " ", -- 
				Copilot = " ", --  
				Enum = "󰕘 ", --  󰕘  ℰ 
				EnumMember = " ", --  
				Event = " ", --  
				Field = " ", --  󰄶  󰆨  󰀻 󰃒 
				File = " ", --    󰈔 󰈙
				Folder = " ", --   󰉋
				Function = "󰊕 ", --  󰊕 
				Interface = " ", --    
				Key = " ", -- 
				Keyword = " ", --   󰌋 
				Method = "󰊕 ", --  󰆧 󰊕 ƒ
				Module = " ", --   󰅩 󰆧 󰏗
				Namespace = "󰦮 ", -- 󰦮   󰅩
				Null = " ", --  󰟢
				Number = "󰎠 ", --  󰎠 
				Object = " ", --   󰅩
				Operator = "󰃬 ", --  󰃬 󰆕 +
				Package = " ", --   󰏖 󰏗 󰆧
				Property = " ", --   󰜢   󰖷
				Reference = "󰈝 ", --  󰈝 󰈇
				Snippet = " ", --  󰘌 ⮡   
				String = " ", --   󰅳
				Struct = "󱏒 ", -- 󰆼   𝓢 󰙅 󱏒
				TabNine = "󰏚 ", -- 󰏚
				Text = "󰉿 ", --   󰉿 𝓐
				TypeParameter = " ", --  󰊄 𝙏
				Unit = " ", --   󰑭 
				Value = " ", --   󰀬 󰎠
				Variable = "󰀫 ", --   󰀫 
			},
		})
	end,
}
