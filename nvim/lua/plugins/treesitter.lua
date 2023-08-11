require'nvim-treesitter.configs'.setup {
  -- 添加不同语言
  ensure_installed = {
    "arduino","bash","c","cmake","cpp","css",
    "dart","dot","func","git_config","git_rebase","gitcommit",
    "gitignore","go","html","hurl","java","javascript",
    "jq","jsdoc","json","json5","latex","lua",
    "luadoc","markdown","markdown_inline","matlab","passwd","perl",
    "php","phpdoc","python","qmljs","query","regex","rego",
    "rust","scss","slint","sql","tsx","typescript",
    "vim","vimdoc","vue","yaml"
  },
  highlight = { enable = true },
  indent = { enable = true },

  -- 不同括号颜色区分
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
}
