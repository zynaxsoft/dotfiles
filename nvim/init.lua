vim.opt.shell='/bin/bash'
vim.opt.termguicolors = true

require('plugins')
require('config')

vim.g.mapleader = [[\<Space>]]
vim.opt.updatetime = 300
-- need to figure out how to properly set these
vim.cmd([[
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
]])

-- Enable type inlay hints
-- autocmd CursorHold,CursorHoldI *.rs :silent! lua require'lsp_extensions'.inlay_hints{
--             \  prefix = ' ==>> ',
--             \  highlight = "Comment",
--             \  enabled = {"TypeHint", "ChainingHint", "ParameterHint"},
--             \  only_current_line = true,
--             \}

-- filetype plugin indent on
-- filetype plugin on

-- prevent the accident wq
vim.cmd('cabbrev wq w')

vim.opt.bs='2'
vim.opt.mouse=a
vim.opt.list = true
vim.opt.listchars=[[tab:»-,trail:⋅,eol:¬,extends:»,precedes:«,nbsp:%]]
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.incsearch = true
vim.opt.showtabline=2

vim.g.indentLine_enabled = 1
vim.g.indentLine_char = '|'
vim.g.indentLine_concealcursor = 'inc'
vim.g.indentLine_conceallevel = 2
vim.g.indentLine_setConceal = 1

vim.opt.foldlevel=99
vim.opt.foldmethod='expr'
vim.opt.foldexpr='nvim_treesitter#foldexpr()'

vim.opt.tabstop=8
vim.opt.expandtab=true
vim.opt.shiftwidth=4
vim.opt.softtabstop=4
vim.opt.smartindent=true
vim.opt.grepprg=[[rg\ --vimgrep]]

vim.cmd([[
  source ~/dotfiles/nvim/configs/wsl-stuff.vim
]])

-- VIM SOLARIZED!!
vim.opt.background='dark'
vim.cmd([[
  au VimEnter * ++nested colorscheme solarized
  augroup MyColorScheme
  au!
  au ColorScheme * hi SignColumn guibg=#073642
  au ColorScheme * hi TabLineFill ctermfg=0 guifg=#073642
  au ColorScheme * hi LspSignatureActiveParameter guifg=#073642 guibg=#93a1a1
  au ColorScheme * hi DiagnosticError ctermfg=1 guifg=#dc322f
  au ColorScheme * hi DiagnosticWarn ctermfg=3 guifg=#cb4b16
  au ColorScheme * hi DiagnosticInfo ctermfg=4 guifg=#586e75
  au ColorScheme * hi DiagnosticHint ctermfg=7 guifg=#586e75
  au ColorScheme * hi DiagnosticSignError guibg=#073642
  au ColorScheme * hi DiagnosticSignWarn guibg=#073642
  au ColorScheme * hi DiagnosticSignInfo guibg=#073642
  au ColorScheme * hi DiagnosticSignHint guibg=#073642
  augroup end

  " Spell check
  setlocal spell spelllang=en_us,cjk
  au VimEnter * hi SpellBad guifg=NONE guibg=NONE gui=undercurl
  syntax on
]])

local map = vim.keymap.set

-- Git
-- git-blame activate by leader b
map('n', '<Leader>b', [[:Gitsigns toggle_current_line_blame<cr>]], { silent = true })
map('n', '<Leader>B', [[:Git blame<cr>]], { silent = true })
-- Fugitive
map('n', '<leader>dd', [[:Gvdiffsplit!<cr>]], { silent = true})
map('n', '<leader>dh', [[:diffget //2<cr>]], { silent = true})
map('n', '<leader>dl', [[:diffget //3<cr>]], { silent = true})
map('n', 'gl', [[:.Gclog!<cr>]])
map('n', 'gL', [[:0Gclog!<cr>]])
map('n', '<leader>fc', [[:Git difftool<cr> :ccl<cr> :Telescope quickfix<cr>]])
map('n', '<leader>fC', [[:Git mergetool<cr> :ccl<cr> :Telescope quickfix<cr>]])

-- Ctrl+h to stop searching
map({'n', 'v'}, '<C-h>', [[:nohlsearch<cr>]], { silent = true})

-- Jump to start and end of line using the home row keys
map('', 'H', '^')
map('', 'L', '$')

map('n', '<c-q>', [[<cmd>TroubleToggle document_diagnostics<cr>]])
map('n', '<a-q>', [[<cmd>TroubleToggle workspace_diagnostics<cr>]])
map('n', '<leader>xq', [[<cmd>TroubleToggle quickfix<cr>]])
map('n', '<leader>xl', [[<cmd>TroubleToggle loclist<cr>]])
map('n', 'gR', [[<cmd>TroubleToggle lsp_references<cr>]])

-- Find files using Telescope command-line sugar.
-- Questionable
map('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').builtin()<cr>]])
map('n', '<leader>fbh', [[<cmd>lua require('telescope.builtin').highlights()<cr>]])
map('n', '<leader>fbc', [[<cmd>lua require('telescope.builtin').commands()<cr>]])

map('n', '<c-p>', [[<cmd>lua require('telescope.gitfile-fallback').project_files()<cr>]])
map('n', '<c-n>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
map('n', '<leader>g', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
map('n', '<leader>G', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]])
map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()\
            \{hidden = true, no_ignore = true, }
            \ )<cr>
            ]])
map('n', '<leader>f:', [[<cmd>lua require('telescope.builtin').command_history()<cr>]])
map('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]])
map('n', '<leader><leader>h', [[<cmd>lua require('telescope.builtin').live_grep(\
            \{cwd='$HOME/dotfiles/nvim'})<cr>]])
map('n', '<leader>f/', [[<cmd>lua require('telescope.builtin').search_history()<cr>]])
map('n', '<leader>fm', [[<cmd>lua require('telescope.builtin').marks()<cr>]])
map('n', '<leader>fq', [[<cmd>lua require('telescope.builtin').quickfix()<cr>]])
map('n', '<leader>fl', [[<cmd>lua require('telescope.builtin').loclist()<cr>]])
map('n', '<leader>fr', [[<cmd>lua require('telescope.builtin').registers()<cr>]])
map('n', '<leader>fe', [[<cmd>lua require('telescope.builtin').keymaps()<cr>]])
map('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').spell_suggest()<cr>]])
map('n', '<leader>fy', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]])
map('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').treesitter()<cr>]])
map('v', '<leader>a', [[:'<,'>Telescope lsp_range_code_actions<cr>]])
map('n', 'gd', [[<cmd>lua require('telescope.builtin').lsp_definitions()<cr>]])
map('n', 'gD', [[<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>]])
map('n', 'gi', [[<cmd>lua require('telescope.builtin').lsp_implementations()<cr>]])
map('n', 'gr', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]])

map('n', '<leader>q', [[:copen<cr>]])
map('n', ']q', [[:cnext<cr>]])
map('n', '[q', [[:cprevious<cr>]])

-- Restart lang server
map('n', '<leader><leader>r', [[<cmd>LspRestart<cr>]], { silent = true })
-- Reload config
map('n', '<leader><leader><c-r>', [[<cmd>source $MYVIMRC<cr>]])
