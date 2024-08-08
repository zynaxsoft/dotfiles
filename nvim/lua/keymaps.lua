local map = vim.keymap.set
-- Git
-- git-blame activate by leader b
map('n', '<Leader>b', [[:Gitsigns toggle_current_line_blame<cr>]], { silent = true })
map('n', '<Leader>B', [[:Git blame<cr>]], { silent = true })
map('n', '<Leader><Leader>B', [[:Git blame -CCC<cr>]], { silent = true })
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
map('n', 'zt', [[zt5<C-y>]], { silent = true })

-- Jump to start and end of line using the home row keys
-- map('', 'H', '^')
-- map('', 'L', '$')

map('n', '<c-q>', [[<cmd>Trouble diagnostic toggle filter.buf=0<cr>]])
map('n', '<a-q>', [[<cmd>Trouble diagnostic toggle<cr>]])
map('n', '<leader>xs', [[<cmd>Trouble symbols toggle focus=false<cr>]])
map('n', '<leader>xL', [[<cmd>Trouble lsp toggle focus=false win.position=right<cr>]])
map('n', '<leader>xq', [[<cmd>Trouble qflist toggle<cr>]])
map('n', '<leader>xl', [[<cmd>Trouble loclist toggle<cr>]])
map('n', 'gR', [[<cmd>TroubleToggle lsp_references<cr>]])

-- Find files using Telescope command-line sugar.
local function telescope_b()
    return require 'telescope.builtin'
end
local function telescope()
    return require 'telescope'
end
map('n', '<leader>fb', function() telescope_b().builtin() end)
map('n', '<leader>fbh', function() telescope_b().highlights() end)
map('n', '<leader>fbc', function() telescope_b().commands() end)

map('n', '<c-p>', require('config.telescope').project_files)
map('n', '<c-n>', function() telescope_b().buffers() end)
-- map('n', '<leader>g', function() telescope_b().live_grep() end)
map('n', '<leader>g', function()
    telescope().extensions.live_grep_args.live_grep_args()
end)
map('n', '<leader>G', function() telescope_b().current_buffer_fuzzy_find() end)
map('n', '<leader>ff', function()
  telescope_b().find_files { hidden = true, no_ignore = true }
end)
map('n', '<leader>f:', function() telescope_b().command_history() end)
map('n', '<leader>fh', function() telescope_b().help_tags() end)
map('n', '<leader><leader>h', function()
  telescope_b().live_grep { cwd = '$HOME/dotfiles/nvim' }
end)
map('n', '<leader>f/', function() telescope_b().search_history() end)
map('n', '<leader>fm', function() telescope_b().marks() end)
map('n', '<leader>fq', function() telescope_b().quickfix() end)
map('n', '<leader>fl', function() telescope_b().loclist() end)
map('n', '<leader>fr', function() telescope_b().registers() end)
map('n', '<leader>fe', function() telescope_b().keymaps() end)
map('n', '<leader>fs', function() telescope_b().spell_suggest() end)
map('n', '<leader>fy', function() telescope_b().lsp_document_symbols() end)
map('n', '<leader>ft', function() telescope_b().treesitter() end)
map('v', '<leader>a', [[:'<,'>Telescope lsp_range_code_actions<cr>]])
map('n', 'gd', function() telescope_b().lsp_definitions() end)
map('n', 'gD', function() telescope_b().lsp_type_definitions() end)
map('n', 'gi', function() telescope_b().lsp_implementations() end)
map('n', 'gr', function() telescope_b().lsp_references() end)

-- harpoon 🔱
map('n', '<leader>N', function() require('harpoon.mark').add_file() end)
map('n', '<leader>n', function() require('harpoon.ui').toggle_quick_menu() end)
map('n', '<leader>1', function() require("harpoon.ui").nav_file(1) end)
map('n', '<leader>2', function() require("harpoon.ui").nav_file(2) end)
map('n', '<leader>3', function() require("harpoon.ui").nav_file(3) end)
map('n', '<leader>4', function() require("harpoon.ui").nav_file(4) end)

-- oil
map('n', 'g-', function() require('oil').open() end)

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

-- Dadbod
map('n', '<Leader><Leader>l', [[:DBUIToggle<cr>]], { silent = true })

-- undotree
map('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Neorg
map('n', '<leader>fn', [[:Neorg workspace<cr>]], { silent = true})
map('n', '<leader>fi', [[:Neorg index<cr>]], { silent = true})

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
