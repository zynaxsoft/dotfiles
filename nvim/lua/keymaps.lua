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
-- map('', 'H', '^')
-- map('', 'L', '$')

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

map('n', '<c-p>', require('config.telescope').project_files)
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

-- harpoon 🔱
map('n', '<leader>n', function() require('harpoon.mark').add_file() end)
map('n', '<A-n>', function() require('harpoon.ui').toggle_quick_menu() end)
map('n', '<leader>1', function() require("harpoon.ui").nav_file(1) end)
map('n', '<leader>2', function() require("harpoon.ui").nav_file(2) end)
map('n', '<leader>3', function() require("harpoon.ui").nav_file(3) end)
map('n', '<leader>4', function() require("harpoon.ui").nav_file(4) end)

-- quickfix
map('n', '<leader>q', [[<cmd>copen<cr>]])
map('n', '<a-j>', [[<cmd>cnext<cr>]])
map('n', '<a-k>', [[<cmd>cprevious<cr>]])

-- nvim-tree
-- C-_ means C-/
map('', '<C-_>', [[<cmd>NvimTreeToggle<cr>]])

-- Restart lang server
map('n', '<leader><leader>r', [[<cmd>LspRestart<cr>]], { silent = true })
-- Reload config
map('n', '<leader><leader><c-r>', [[<cmd>source $MYVIMRC<cr>]])
