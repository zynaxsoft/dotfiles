set nocompatible
filetype off
set shell=/bin/bash

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
let g:indentLine_char = '|'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_setConceal = 1

set background=dark
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Spell check
syntax enable
setlocal spell spelllang=en_us,cjk
hi clear SpellBad
hi SpellBad ctermfg=1 cterm=underline
syntax on

au Filetype rust set colorcolumn=100

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set smartindent

