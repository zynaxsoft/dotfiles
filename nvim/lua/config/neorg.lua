require('neorg').setup {
  load = {
    ['core.autocommands'] = {},
    ['core.defaults'] = {}, -- Loads default behaviour
    ['core.concealer'] = {}, -- Adds pretty icons to your documents
    ['core.completion'] = {
      config = {
        engine = 'nvim-cmp',
      },
    },
    ['core.ui.calendar'] = {},
    ['core.integrations.nvim-cmp'] = {},
    ['core.integrations.treesitter'] = {},
    ['core.integrations.telescope'] = {},
    ['core.dirman'] = { -- Manages Neorg workspaces
      config = {
        workspaces = {
          notes = '~/notes',
        },
      },
    },
  },
}
