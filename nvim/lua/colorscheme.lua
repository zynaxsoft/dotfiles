-- VIM SOLARIZED!!
vim.opt.background = 'dark'
vim.cmd [[
  au VimEnter * ++nested colorscheme catppuccin
  augroup MyColorScheme
  au!
  "au ColorScheme * hi SignColumn guibg=#073642
  "au ColorScheme * hi TabLineFill ctermfg=0 guifg=#073642
  "au ColorScheme * hi LspSignatureActiveParameter guifg=#073642 guibg=#93a1a1
  "au ColorScheme * hi DiagnosticError ctermfg=1 guifg=#dc322f
  "au ColorScheme * hi DiagnosticWarn ctermfg=3 guifg=#cb4b16
  "au ColorScheme * hi DiagnosticInfo ctermfg=4 guifg=#586e75
  "au ColorScheme * hi DiagnosticHint ctermfg=7 guifg=#586e75
  "au ColorScheme * hi DiagnosticSignError guibg=#073642
  "au ColorScheme * hi DiagnosticSignWarn guibg=#073642
  "au ColorScheme * hi DiagnosticSignInfo guibg=#073642
  "au ColorScheme * hi DiagnosticSignHint guibg=#073642
  augroup end

  " Spell check
  setlocal spell spelllang=en_us,cjk
  au VimEnter * hi SpellBad guifg=NONE guibg=NONE gui=undercurl
  syntax on
]]
