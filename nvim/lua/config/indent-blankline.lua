vim.cmd [[
  augroup MyIndentBlanklineColor
  au!
    au VimEnter * hi IndentBlanklineChar guifg=#324d4d
    au VimEnter * hi IndentBlanklineContextChar guifg=#629999
  augroup end
]]
require('indent_blankline').setup {
  space_char_blankline = ' ',
  show_current_context = true,
}
