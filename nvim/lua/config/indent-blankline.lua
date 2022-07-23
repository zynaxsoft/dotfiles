vim.cmd [[
  augroup MyIndentBlanklineColor
  au!
    au VimEnter * hi IndentBlanklineChar guifg=#324d4d gui=NONE
    au VimEnter * hi IndentBlanklineContextChar guifg=#629999 gui=NONE
    au VimEnter * hi IndentBlanklineSpaceChar gui=NONE
    au VimEnter * hi IndentBlanklineSpaceCharBlankline gui=NONE
  augroup end
]]
require('indent_blankline').setup {
  space_char_blankline = ' ',
  show_current_context = true,
}
