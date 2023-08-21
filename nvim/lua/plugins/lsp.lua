require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
  ensure_installed = {
    "lua_ls",
    "html",
    "cssls",
    "tsserver",
    "vuels",
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 必须想下面这样配置每个语言，不上未配置语言的dropbar symbol不显示
require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
}

require("lspconfig").html.setup {
  capabilities = capabilities,
}

require("lspconfig").cssls.setup {
  capabilities = capabilities,
}

require("lspconfig").tsserver.setup {
  capabilities = capabilities,
}

require("lspconfig").vuels.setup {
  capabilities = capabilities,
}

