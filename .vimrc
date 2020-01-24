set nocompatible
filetype off
set shell=/bin/bash

call plug#begin('~/.vim/plugged')

Plug 'davidhalter/jedi-vim'
Plug 'Yggdroot/indentLine'
Plug 'altercation/vim-colors-solarized'
" Plug 'vim-syntastic/syntastic'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'w0rp/ale'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
Plug 'zivyangll/git-blame.vim'
Plug 'tpope/vim-fugitive'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'Valloric/YouCompleteMe'

call plug#end()
filetype plugin indent on
filetype plugin on

set bs=2

set list
set listchars=tab:»-,trail:⋅,eol:¬,extends:»,precedes:«,nbsp:%
set ignorecase
set smartcase

set showtabline=2

" set timeoutlen=1000 ttimeoutlen=0

set hlsearch

let g:indentLine_enabled = 1
" let g:indentLine_color_term = 239
let g:indentLine_char = '|'
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_setConceal = 1

" VIM SOLARIZED!!
syntax enable
set background=dark
colorscheme solarized

" Spell check
syntax enable
setlocal spell spelllang=en_us,cjk
hi clear SpellBad
hi SpellBad ctermfg=1 cterm=underline
syntax on

let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = "1"
let g:jedi#use_tabs_not_buffers = 1

" pep8
let g:ale_python_pylint_executable = '/usr/bin/python3'
let g:ale_python_pylint_options = '-m pylint --errors-only --disable E1101,E0401'
let g:ale_python_flake8_executable = 'flake8'
let g:ale_python_flake8_options = '--ignore "I100, I101, E123, W503"'
let g:ale_python_autopep8_executable = '/usr/bin/python3'
let g:ale_python_autopep8_options = '-m autopep8'
let g:ale_python_isort_executable = '/usr/bin/python3'
let g:ale_python_isort_options = '-m isort'
"let g:ale_python_black_executable = '/usr/bin/python3'
"let g:ale_python_black_options = '-m black'
let g:ale_python_yapf_executable = '/usr/bin/yapf'
let g:ale_python_yapf_options = ''

let g:ale_python_pylint_use_global = 1
let g:ale_completion_enabled = 1


let g:ale_rust_cargo_check_all_targets = 1
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_check_tests = 1

let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_filetype_changed = 1

let g:ale_sign_error = '🤔'
let g:ale_sign_warning = '😡'

"let g:ale_open_list = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_list_window_size = 4

au VimEnter * highlight SignColumn ctermbg=10
au VimEnter * highlight clear ALEErrorSign
au VimEnter * highlight clear ALEWarningSign

"set omnifunc=ale#completion#OmniFunc
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python': ['autopep8', 'isort', 'yapf'],
\   'rust': ['rustfmt'],
\}
let g:ale_linters = {
    \ 'python': ['flake8', 'pylint'],
    \ 'rust': ['rls', 'cargo'],
    \ }
nmap <Leader>x <Plug>(ale_fix)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-l> <Plug>(ale_detail)
"nmap <silent> <C-h> <Plug>(ale_hover)

"let g:syntastic_python_pylint_exe = 'python3 -m pylint'
"let g:syntastic_python_checkers = ['pylint']
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
""let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
""let g:syntastic_check_on_wq = 0
"let g:syntastic_enable_signs = 1

" pep8 indent
let g:python_pep8_indent_hang_closing = 1

" snippets
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"


" Git
" git-blame activate by leader b
nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>

filetype indent plugin on

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set smartindent

"set number

" highlight the length over 80column
" highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
" match OverLength /\%81v.*/

"setlocal spell spelllang=en_us,cjk
hi clear SpellBad
hi SpellBad ctermfg=1 cterm=underline


set smartindent

" Markdown
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_conceal = 0

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
