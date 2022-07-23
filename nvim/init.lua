vim.opt.shell = '/bin/bash'
vim.opt.termguicolors = true
-- <Space> as the leader 🪜
vim.g.mapleader = ' '

require 'plugins'
require 'config'

vim.opt.updatetime = 300
-- need to figure out how to properly set these
vim.cmd [[
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
]]

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
vim.cmd 'cabbrev wq w'

vim.opt.bs = '2'
vim.opt.mouse = 'a'
vim.opt.list = true
vim.opt.listchars = [[tab:»-,trail:⋅,eol:¬,extends:»,precedes:«,nbsp:%]]
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.incsearch = true
vim.opt.showtabline = 2

vim.g.indentLine_enabled = 1
vim.g.indentLine_char = '|'
vim.g.indentLine_concealcursor = 'inc'
vim.g.indentLine_conceallevel = 2
vim.g.indentLine_setConceal = 1

vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.grepprg = [[rg --vimgrep]]

vim.cmd [[
  source ~/dotfiles/nvim/configs/wsl-stuff.vim
]]

-- VIM SOLARIZED!!
vim.opt.background = 'dark'
vim.cmd [[
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
]]

local map = vim.keymap.set
-- Git
-- git-blame activate by leader b
map('n', '<Leader>b', [[:Gitsigns toggle_current_line_blame<cr>]], { silent = true })
map('n', '<Leader>B', [[:Git blame<cr>]], { silent = true })
-- Fugitive
map('n', '<leader>dd', [[:Gvdiffsplit!<cr>]], { silent = true })
map('n', '<leader>dh', [[:diffget //2<cr>]], { silent = true })
map('n', '<leader>dl', [[:diffget //3<cr>]], { silent = true })
map('n', 'gl', [[:.Gclog!<cr>]])
map('n', 'gL', [[:0Gclog!<cr>]])
map('n', '<leader>fc', [[:Git difftool<cr> :ccl<cr> :Telescope quickfix<cr>]])
map('n', '<leader>fC', [[:Git mergetool<cr> :ccl<cr> :Telescope quickfix<cr>]])

-- Ctrl+h to stop searching
map({ 'n', 'v' }, '<C-h>', [[:nohlsearch<cr>]], { silent = true })

-- Jump to start and end of line using the home row keys
map('', 'H', '^')
map('', 'L', '$')

map('n', '<c-q>', [[<cmd>TroubleToggle document_diagnostics<cr>]])
map('n', '<a-q>', [[<cmd>TroubleToggle workspace_diagnostics<cr>]])
map('n', '<leader>xq', [[<cmd>TroubleToggle quickfix<cr>]])
map('n', '<leader>xl', [[<cmd>TroubleToggle loclist<cr>]])
map('n', 'gR', [[<cmd>TroubleToggle lsp_references<cr>]])

-- Find files using Telescope command-line sugar.
local telescope = require 'telescope.builtin'
map('n', '<leader>fb', telescope.builtin)
map('n', '<leader>fbh', telescope.highlights)
map('n', '<leader>fbc', telescope.commands)

map('n', '<c-p>', require('telescope.gitfile-fallback').project_files)
map('n', '<c-n>', telescope.buffers)
map('n', '<leader>g', telescope.live_grep)
map('n', '<leader>G', telescope.current_buffer_fuzzy_find)
map('n', '<leader>ff', function()
  telescope.find_files { hidden = true, no_ignore = true }
end)
map('n', '<leader>f:', telescope.command_history)
map('n', '<leader>fh', telescope.help_tags)
map('n', '<leader><leader>h', function()
  telescope.live_grep { cwd = '$HOME/dotfiles/nvim' }
end)
map('n', '<leader>f/', telescope.search_history)
map('n', '<leader>fm', telescope.marks)
map('n', '<leader>fq', telescope.quickfix)
map('n', '<leader>fl', telescope.loclist)
map('n', '<leader>fr', telescope.registers)
map('n', '<leader>fe', telescope.keymaps)
map('n', '<leader>fs', telescope.spell_suggest)
map('n', '<leader>fy', telescope.lsp_document_symbols)
map('n', '<leader>ft', telescope.treesitter)
map('v', '<leader>a', [[:'<,'>Telescope lsp_range_code_actions<cr>]])
map('n', 'gd', telescope.lsp_definitions)
map('n', 'gD', telescope.lsp_type_definitions)
map('n', 'gi', telescope.lsp_implementations)
map('n', 'gr', telescope.lsp_references)

-- quickfix
map('n', '<leader>q', [[<cmd>copen<cr>]])
map('n', ']q', [[<cmd>cnext<cr>]])
map('n', '[q', [[<cmd>cprevious<cr>]])

-- Restart lang server
map('n', '<leader><leader>r', [[<cmd>LspRestart<cr>]], { silent = true })
-- Reload config
map('n', '<leader><leader><c-r>', [[<cmd>source $MYVIMRC<cr>]])
