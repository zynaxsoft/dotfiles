vim.cmd [[
  augroup MyIndentBlanklineColor
  au!
    au VimEnter * hi IndentBlanklineChar guifg=NONE gui=NONE
    au VimEnter * hi IndentBlanklineContextChar guifg=NONE gui=NONE
    au VimEnter * hi IndentBlanklineSpaceChar guifg=NONE gui=NONE
    au VimEnter * hi IndentBlanklineSpaceCharBlankline gui=NONE
  augroup end
]]
require('indent_blankline').setup {
  space_char_blankline = ' ',
  show_current_context = true,
  use_treesitter = true,
  use_treesitter_scope = true,
}
