set nocompatible
filetype off
set shell=/bin/bash

" Use Coc lsp instead
let g:ale_disable_lsp = 1

call plug#begin('~/.config/nvim/plugged')

" Show indent line
Plug 'Yggdroot/indentLine'

" Solarized!
" Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'

" General tools
Plug 'godlygeek/tabular'
Plug 'w0rp/ale'

" Git
Plug 'tpope/vim-fugitive'
Plug 'zivyangll/git-blame.vim'

" Completer
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }

" Tmux stuff
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux-focus-events'

" Color
Plug 'norcalli/nvim-colorizer.lua'

" Lang specifics
Plug 'rust-lang/rust.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'rhysd/vim-clang-format'
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'hashivim/vim-terraform'
Plug 'jparise/vim-graphql'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Highlight and preview pattern/regex
Plug 'markonm/traces.vim'

" FZF for navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

filetype plugin indent on
filetype plugin on

" prevent the accident wq
cabbrev wq w

let mapleader = "\<Space>"

set bs=2

set mouse=a

set list
set listchars=tab:»-,trail:⋅,eol:¬,extends:»,precedes:«,nbsp:%
set ignorecase
set smartcase

set showtabline=2
set incsearch

let g:indentLine_enabled = 1
" let g:indentLine_color_term = 239
let g:indentLine_char = '|'
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_setConceal = 1

" VIM SOLARIZED!!
au VimEnter * ++nested colorscheme solarized8
set background=dark
" silent! colorscheme solarized
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
au VimEnter * hi TabLineFill ctermfg=0 guifg=#073642

" Spell check
syntax enable
setlocal spell spelllang=en_us,cjk
hi clear SpellBad
hi SpellBad ctermfg=1 cterm=underline
syntax on

" FZF
let g:fzf_layout = { 'down': '~20%' }
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
"map <C-p> :GFiles --exclude-standard --others --cached<CR>
command! -bang -nargs=* Files
            \ call fzf#vim#files(<q-args>, {}, <bang>0)
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
map <C-n> :Buffers<CR>

" <leader>s for Rg search
noremap <leader>s :Rg<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --hidden --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" Git
" git-blame activate by leader b
nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>

" Stop search with Enter key
map <cr> :nohlsearch<cr>
" Jump to start and end of line using the home row keys
map H ^
map L $

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_no_extensions_in_markdown = 1

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set smartindent


source ~/dotfiles/nvim/configs/wsl-stuff.vim
source ~/dotfiles/nvim/configs/coc-stuff.vim
source ~/dotfiles/nvim/configs/ale-stuff.vim
source ~/dotfiles/nvim/configs/rust-stuff.vim
source ~/dotfiles/nvim/configs/python-stuff.vim

lua require'colorizer'.setup()

