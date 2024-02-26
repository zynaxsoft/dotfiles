local map = vim.keymap.set
-- Git
-- git-blame activate by leader b
map('n', '<Leader>b', [[:Gitsigns toggle_current_line_blame<cr>]], { silent = true })
map('n', '<Leader>B', [[:Git blame<cr>]], { silent = true })
-- Fugitive
map('n', '<leader>dd', [[:Gvdiffsplit!<cr>]], { silent = true })
map('n', '<leader>dm', [[:Git mergetool<cr>]], { silent = true })
map('n', '<leader>dh', [[:diffget //2<cr>]], { silent = true })
map('n', '<leader>dl', [[:diffget //3<cr>]], { silent = true })
map('n', 'gl', [[:.Gclog!<cr>]])
map('n', 'gL', [[:0Gclog!<cr>]])
map('n', '<leader>fc', [[:Git difftool<cr> :ccl<cr> :Telescope quickfix<cr>]])
map('n', '<leader>fC', [[:Git mergetool<cr> :ccl<cr> :Telescope quickfix<cr>]])

-- Packer & Mason
map('n', '<leader><leader>p', [[:Lazy<cr>]])
map('n', '<leader><leader>m', [[:Mason<cr>]])

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
function telescope()
    return require 'telescope.builtin'
end
map('n', '<leader>fb', function() telescope().builtin() end)
map('n', '<leader>fbh', function() telescope().highlights() end)
map('n', '<leader>fbc', function() telescope().commands() end)

map('n', '<c-p>', require('config.telescope').project_files)
map('n', '<c-n>', function() telescope().buffers() end)
map('n', '<leader>g', function() telescope().live_grep() end)
map('n', '<leader>G', function() telescope().current_buffer_fuzzy_find() end)
map('n', '<leader>ff', function()
  telescope().find_files { hidden = true, no_ignore = true }
end)
map('n', '<leader>f:', function() telescope().command_history() end)
map('n', '<leader>fh', function() telescope().help_tags() end)
map('n', '<leader><leader>h', function()
  telescope().live_grep { cwd = '$HOME/dotfiles/nvim' }
end)
map('n', '<leader>f/', function() telescope().search_history() end)
map('n', '<leader>fm', function() telescope().marks() end)
map('n', '<leader>fq', function() telescope().quickfix() end)
map('n', '<leader>fl', function() telescope().loclist() end)
map('n', '<leader>fr', function() telescope().registers() end)
map('n', '<leader>fe', function() telescope().keymaps() end)
map('n', '<leader>fs', function() telescope().spell_suggest() end)
map('n', '<leader>fy', function() telescope().lsp_document_symbols() end)
map('n', '<leader>ft', function() telescope().treesitter() end)
map('v', '<leader>a', [[:'<,'>Telescope lsp_range_code_actions<cr>]])
map('n', 'gd', function() telescope().lsp_definitions() end)
map('n', 'gD', function() telescope().lsp_type_definitions() end)
map('n', 'gi', function() telescope().lsp_implementations() end)
map('n', 'gr', function() telescope().lsp_references() end)

-- harpoon 🔱
map('n', '<leader>N', function() require('harpoon.mark').add_file() end)
map('n', '<leader>n', function() require('harpoon.ui').toggle_quick_menu() end)
map('n', '<leader>1', function() require("harpoon.ui").nav_file(1) end)
map('n', '<leader>2', function() require("harpoon.ui").nav_file(2) end)
map('n', '<leader>3', function() require("harpoon.ui").nav_file(3) end)
map('n', '<leader>4', function() require("harpoon.ui").nav_file(4) end)

-- crates
map('n', '<leader>cf', function() require('crates').show_features_popup() end)
map('n', '<leader>cv', function() require('crates').show_versions_popup() end)
map('n', '<leader>cd', function() require('crates').show_dependencies_popup() end)

-- ufo
map('n', 'zR', function() require('ufo').openAllFolds() end)
map('n', 'zM', function() require('ufo').closeAllFolds() end)
map('n', 'zr', function() require('ufo').openFoldsExceptKinds() end)
map('n', 'zf', function(n)
    require('ufo').openFoldsExceptKinds()
    require('ufo').closeFoldsWith(n)
end)
map('n', 'zm', function() require('ufo').closeFoldsWith() end) -- closeAllFolds == closeFoldsWith(0)
map('n', 'zk', function()
  require('ufo').peekFoldedLinesUnderCursor()
end)

-- undotree
map('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Neorg
map('n', '<leader>fn', [[:Neorg workspace<cr>]])
map('n', '<leader>fi', [[:Neorg index<cr>]])

-- quickfix
map('n', '<leader>q', [[<cmd>copen<cr>]])
map('n', ']q', [[<cmd>cnext<cr>]])
map('n', '[q', [[<cmd>cprevious<cr>]])

-- nvim-tree
-- C-_ means C-/
map('', '<C-_>', [[<cmd>Neotree toggle<cr>]])

-- Restart lang server
map('n', '<leader><leader>r', [[<cmd>LspRestart<cr>]], { silent = true })
-- Reload config
map('n', '<leader><leader><c-r>', [[<cmd>source $MYVIMRC<cr>]])

-- Disalbe unintentional q:
map('n', 'q:', '<nop>', { silent = true })
