set nocompatible
filetype off
set shell=/bin/bash

call plug#begin('~/.config/nvim/plugged')

" GUI
Plug 'ishan9299/nvim-solarized-lua'
Plug 'nvim-lualine/lualine.nvim'
" Show indent line
Plug 'Yggdroot/indentLine'
" Highlight and preview pattern/regex
Plug 'markonm/traces.vim'
" Color
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lewis6991/spellsitter.nvim'

" Common dependencies
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'godlygeek/tabular'

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/cmp-cmdline', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'
Plug 'onsails/lspkind-nvim'
" Diagnostic stuff
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'folke/trouble.nvim'

" Motions
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'

" Tools
Plug 'nvim-telescope/telescope.nvim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" Tmux stuff
Plug 'roxma/vim-tmux-clipboard'

" Lang specifics
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
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

call plug#end()

let mapleader = "\<Space>"
set updatetime=300
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" Lua stuff goes here!!
lua require('config')
" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :silent! lua require'lsp_extensions'.inlay_hints{
            \  prefix = ' ==>> ',
            \  highlight = "Comment",
            \  enabled = {"TypeHint", "ChainingHint", "ParameterHint"},
            \  only_current_line = true,
            \}

filetype plugin indent on
filetype plugin on

" prevent the accident wq
cabbrev wq w


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
au VimEnter * ++nested colorscheme solarized
set background=dark
au VimEnter * hi SignColumn guibg=#073642
au VimEnter * hi TabLineFill ctermfg=0 guifg=#073642
au VimEnter * hi LspSignatureActiveParameter guifg=#073642 guibg=#93a1a1
au VimEnter * hi DiagnosticError ctermfg=1 guifg=#dc322f
au VimEnter * hi DiagnosticWarn ctermfg=3 guifg=#cb4b16
au VimEnter * hi DiagnosticInfo ctermfg=4 guifg=#586e75
au VimEnter * hi DiagnosticHint ctermfg=7 guifg=#586e75
au VimEnter * hi DiagnosticSignError guibg=#073642
au VimEnter * hi DiagnosticSignWarn guibg=#073642
au VimEnter * hi DiagnosticSignInfo guibg=#073642
au VimEnter * hi DiagnosticSignHint guibg=#073642

" Spell check
" Spell check doesn't work well with Treesitter
" We need lewis6991/spellsitter.nvim to make spellcheck sane
" Otherwize, we will get underline everywhere.
setlocal spell spelllang=en_us,cjk
au VimEnter * hi SpellBad guifg=NONE guibg=NONE gui=undercurl
syntax on

" Git
" git-blame activate by leader b
nnoremap <Leader>b :Gitsigns toggle_current_line_blame<cr>
nnoremap <Leader>B :Git blame<cr>
" Fugitive
nnoremap <leader>dd :Gvdiffsplit!<cr>
nnoremap <leader>dh :diffget //2<cr>
nnoremap <leader>dl :diffget //3<cr>
nnoremap gl :.Gclog!<cr>
nnoremap gL :0Gclog!<cr>
nnoremap <leader>fc :Git difftool<cr> :ccl<cr> :Telescope quickfix<cr>
nnoremap <leader>fC :Git mergetool<cr> :ccl<cr> :Telescope quickfix<cr>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

nnoremap <c-q> <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>q <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" Find files using Telescope command-line sugar.
" Questionable
nnoremap <leader>fb <cmd>lua require('telescope.builtin').builtin()<cr>
nnoremap <leader>fbh <cmd>lua require('telescope.builtin').highlights()<cr>
nnoremap <leader>fbc <cmd>lua require('telescope.builtin').commands()<cr>

nnoremap <c-p> <cmd>lua require('telescope.gitfile-fallback').project_files()<cr>
nnoremap <c-n> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>G <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files(
            \{hidden = true, no_ignore = true, }
            \ )<cr>
nnoremap <leader>f: <cmd>lua require('telescope.builtin').command_history()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader><leader>h <cmd>lua require('telescope.builtin').live_grep(
            \{cwd='$HOME/dotfiles/nvim'})<cr>
nnoremap <leader>f/ <cmd>lua require('telescope.builtin').search_history()<cr>
nnoremap <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>fq <cmd>lua require('telescope.builtin').quickfix()<cr>
nnoremap <leader>fl <cmd>lua require('telescope.builtin').loclist()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').registers()<cr>
nnoremap <leader>fe <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').spell_suggest()<cr>
nnoremap <leader>fy <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').treesitter()<cr>
nnoremap <leader>a <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
vnoremap <leader>a :'<,'>Telescope lsp_range_code_actions<cr>
nnoremap gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap gD <cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>
nnoremap gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>

" Reload config
nnoremap <leader><leader><c-r> <cmd>source $MYVIMRC<cr>

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_no_extensions_in_markdown = 1

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'

set foldlevel=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set smartindent


source ~/dotfiles/nvim/configs/wsl-stuff.vim
source ~/dotfiles/nvim/configs/rust-stuff.vim
source ~/dotfiles/nvim/configs/python-stuff.vim

function Booboo()
    :TSInstall! rust python bash css html yaml json toml tsx vim cpp html c cmake http make regex javascript
endfunction
