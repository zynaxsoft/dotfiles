require 'options'
require 'disable-plugins'
require 'lazyplugin'
require 'config'
require 'colorscheme'
require 'keymaps'
require 'gui'

-- temp fix for folding doesn't work when open file with telescope
-- use this until the issue below is resolved
-- https://github.com/nvim-telescope/telescope.nvim/issues/699
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    command = "normal zx",
})
