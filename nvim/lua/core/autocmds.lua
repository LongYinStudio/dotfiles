-- Auto format files
vim.cmd[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]]
-- 在进入普通模式时自动保存文件
vim.cmd[[
autocmd InsertLeave * silent! write
]]
