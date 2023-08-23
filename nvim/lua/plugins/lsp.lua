require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

local languages = {
  "lua_ls",
  "html",
  "emmet_ls",
  "cssls",
  "tsserver",
  "vuels",
  "volar",
  "clangd",
  "jsonls",
  "tailwindcss",
  "bashls",
  "dockerls",
  "pyright",
  "yamlls",
}

require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
  ensure_installed = languages,
  automatic_installation = true, --自动安装
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 必须想下面这样配置每个语言，不上未配置语言的dropbar symbol不显示

for _, language in ipairs(languages) do
  require("lspconfig")[language].setup {
    capabilities = capabilities,
  }
end

require'lsp-lens'.setup({
  enable = true,
  include_declaration = true,      -- Reference include declaration
  sections = {                      -- Enable / Disable specific request
    definition = true,
    references = true,
    implements = true,
  },
  ignore_filetype = {
    "prisma",
  },
})

