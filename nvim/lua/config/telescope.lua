require('telescope').setup {
  defaults = {
    -- Default configuration for telescope goes here:
    initial_mode = 'insert',
    winblend = 15,
    layout_strategy = 'vertical',
    layout_config = {},
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim',
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    -- require("telescope").setup {
    buffers = {
      show_all_buffers = true,
      -- sort_lastused = true,
      mappings = {
        i = {
          ['<c-d>'] = 'delete_buffer',
        },
      },
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {
        -- even more opts
      },
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    },
  },
}
require('telescope').load_extension 'ui-select'
