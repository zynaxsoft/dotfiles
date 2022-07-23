vim.opt.shell = '/bin/bash'
vim.opt.termguicolors = true
-- <Space> as the leader 🪜
vim.g.mapleader = ' '
vim.opt.updatetime = 300
-- need to figure out how to properly set these
vim.cmd [[
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
]]

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
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = [[nvim_treesitter#foldexpr()]]

vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.grepprg = [[rg --vimgrep]]

vim.opt.lazyredraw = true

vim.cmd [[
  source ~/dotfiles/nvim/configs/wsl-stuff.vim
]]
