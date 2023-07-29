local telescope = require('telescope')
local builtin = require('telescope.builtin')
local status, actions = pcall(require, "telescope.actions")
local previewers = require('telescope.previewers')
local action_layout = require("telescope.actions.layout")
if (not status) then
  return
end

-- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})  -- 环境里要安装ripgrep
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

telescope.setup({
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
        ["l"] = actions.file_edit
      },
      i = {
        ["?"] = action_layout.toggle_preview,
      },
    },
    file_ignore_patterns = {"./node_modules"},
  },
})

