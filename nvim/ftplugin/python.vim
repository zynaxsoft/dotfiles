syntax on
filetype indent plugin on

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

"set number

" highlight the length over 80column
" highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
" match OverLength /\%81v.*/
set colorcolumn=100

"setlocal spell spelllang=en_us,cjk
hi clear SpellBad
hi SpellBad ctermfg=1 cterm=underline

