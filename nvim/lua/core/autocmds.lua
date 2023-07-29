-- Auto format files
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = '*.lua,*.go,*.rb,*.json,*.js',
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
