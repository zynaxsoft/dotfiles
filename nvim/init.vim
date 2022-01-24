set nocompatible
filetype off
set shell=/bin/bash

call plug#begin('~/.config/nvim/plugged')

" Show indent line
Plug 'Yggdroot/indentLine'

" Solarized!
" Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'

" General tools
Plug 'godlygeek/tabular'

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'zivyangll/git-blame.vim'

" Tmux stuff
Plug 'roxma/vim-tmux-clipboard'

" Color
Plug 'norcalli/nvim-colorizer.lua'

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

" Highlight and preview pattern/regex
Plug 'markonm/traces.vim'

" FZF for navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

let mapleader = "\<Space>"
set updatetime=300

" LSP configuration
lua << END
local cmp = require'cmp'

local lspconfig = require'lspconfig'
cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- Tab immediately completes. C-n/C-p to select.
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = cmp.config.sources({
    -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  })
})

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<C-l>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  local signs = { Error = "😡", Warn = "🤔", Hint = "👌", Info = "💡" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    bind = true,
    -- doc_lines = 0,
    handler_opts = {
      border = "rounded"
    },
    hi_parameter = "LspSignatureActiveParameter",
  })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.pyright.setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      -- completion = {
      --   postfix = {
      --     enable = false,
      --   },
      -- },
    },
  },
  capabilities = capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

require("trouble").setup {
  signs = {
    -- icons / text used for a diagnostic
    error = "😡",
    warning = "🤔",
    hint = "👌",
    information = "💡",
    other = "✔"
  },
}
END

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{
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
au VimEnter * ++nested colorscheme solarized8
set background=dark
" silent! colorscheme solarized
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
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
au VimEnter * hi SignColumn guibg=#073642

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

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

nnoremap <leader>q <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

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
source ~/dotfiles/nvim/configs/rust-stuff.vim
source ~/dotfiles/nvim/configs/python-stuff.vim

lua require'colorizer'.setup()

