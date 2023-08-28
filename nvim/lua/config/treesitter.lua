treesitter = {}
function treesitter.main()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'python', 'lua', 'rust' },
    auto_install = true,
    highlight = {
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }
  -- make treesitter parse Octo.nvim buffer page
  local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
  parser_config.markdown.filetype_to_parsername = 'octo'
end

function treesitter.context()
  require('treesitter-context').setup {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20, -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
  }
end

function treesitter.textobjects()
  require('nvim-treesitter.configs').setup {
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      -- swap = {
      --   enable = true,
      --   swap_next = {
      --     ["<leader>a"] = "@parameter.inner",
      --   },
      --   swap_previous = {
      --     ["<leader>A"] = "@parameter.inner",
      --   },
      -- },
      -- move = {
      --   enable = true,
      --   set_jumps = true, -- whether to set jumps in the jumplist
      --   goto_next_start = {
      --     ["]m"] = "@function.outer",
      --     ["]]"] = "@class.outer",
      --   },
      --   goto_next_end = {
      --     ["]M"] = "@function.outer",
      --     ["]["] = "@class.outer",
      --   },
      --   goto_previous_start = {
      --     ["[m"] = "@function.outer",
      --     ["[["] = "@class.outer",
      --   },
      --   goto_previous_end = {
      --     ["[M"] = "@function.outer",
      --     ["[]"] = "@class.outer",
      --   },
      -- },
    },
  }
end

function treesitter.spell()
  require('spellsitter').setup {
    -- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
    enable = true,
  }
end

return treesitter
