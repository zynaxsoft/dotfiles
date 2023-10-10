vim.cmd [[
  augroup MyIndentBlanklineColor
  au!
    au VimEnter * hi IblScope guifg=#f4dbd6 gui=BOLD
  augroup end
]]
require('ibl').setup {
  indent = {
    char = '╎',
    tab_char = '╎',
  },
  whitespace = {
    remove_blankline_trail = true,
  },
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
  },
}
