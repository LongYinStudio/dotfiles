-- Auto format files
vim.cmd[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]]
