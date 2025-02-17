local M = {}
function M.setup()
  local my_layout = {
    anchor = 'N',
    -- height = 0.5,
    mirror = true,
  }
  local lga_actions = require("telescope-live-grep-args.actions")
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
        '--hidden',
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
      git_files = {
        layout_config = my_layout,
      },
      find_files = {
        layout_config = my_layout,
      },
      buffers = {
        layout_config = my_layout,
        -- previewer = false,
        show_all_buffers = true,
        -- ignore_current_buffer = true,
        sort_mru = true,
        -- sort_lastused = true,
        mappings = {
          i = {
            ['<c-d>'] = 'delete_buffer',
          },
        },
      },
    },
    extensions = {
      -- ['ui-select'] = {
      --   require('telescope.themes').get_dropdown {
      --     -- even more opts
      --   },
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
      -- },
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        mappings = { -- extend mappings
          i = {
            ['<C-k>'] = lga_actions.quote_prompt(),
            ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
          },
        },
        -- ... also accepts theme settings, for example:
        -- theme = "dropdown", -- use dropdown theme
        -- theme = { }, -- use own theme spec
        -- layout_config = { mirror=true }, -- mirror preview pane
      },
    },
  }
  require('telescope').load_extension 'ui-select'
  require('telescope').load_extension 'live_grep_args'
end

function M.project_files()
  local file_opts = {
    no_ignore = true,
    hidden = true,
  }
  local git_opts = {
    show_untracked = true,
  }
  local ok = pcall(require('telescope.builtin').git_files, git_opts)
  if not ok then
    require('telescope.builtin').find_files(file_opts)
  end
end

return M
