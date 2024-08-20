vim.cmd([[
  if system('uname -r') =~ "microsoft"
      let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location
      if executable(s:clip)
          augroup WSLYank
              autocmd!
              autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
          augroup END
      end
  end
]])
