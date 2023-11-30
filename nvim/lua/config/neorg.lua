require('neorg').setup {
  load = {
    ['core.defaults'] = {}, -- Loads default behaviour
    ['core.concealer'] = {
      config = {
        icon_preset = 'basic',
      },
    },
    ['core.completion'] = {
      config = {
        engine = 'nvim-cmp',
      },
    },
    ['core.ui.calendar'] = {},
    ['core.autocommands'] = {},
    ['core.neorgcmd'] = {},
    ['core.mode'] = {},
    ['core.neorgcmd.commands.return'] = {},
    ['core.integrations.nvim-cmp'] = {},
    ['core.integrations.treesitter'] = {},
    ['core.integrations.telescope'] = {},
    ['core.dirman'] = { -- Manages Neorg workspaces
      config = {
        workspaces = {
          notes = '~/notes',
        },
        default_workspace = 'notes',
      },
    },
  },
}
