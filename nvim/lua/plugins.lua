return {
  -- Core
  { 'nvim-lua/plenary.nvim', lazy = true },

  -- GUI
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require 'config.catppuccin'
    end,
    lazy = true,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'config.lualine'
    end,
    dependencies = { 'arkav/lualine-lsp-progress', 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
  },

  -- Show indent line
  -- 'Yggdroot/indentLine'
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require 'config.indent-blankline'
    end,
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- Color
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = require('config.treesitter').main,
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = require('config.treesitter').context,
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = require('config.treesitter').textobjects,
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- Tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    lazy = true,
    deactivate = function()
      vim.cmd [[Neotree close]]
    end,
    config = function()
      require 'config.neo-tree'
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        's1n7ax/nvim-window-picker',
        version = 'v1.*',
        config = function()
          require('window-picker').setup {
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', 'quickfix' },
              },
            },
            other_win_hl_color = '#e35e4f',
          }
        end,
      },
    },
  },
  {
    'stevearc/oil.nvim',
    config = function()
      require 'config.oil'
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    cmd = 'Oil',
  },

  -- Folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      require 'config.ufo'
    end,
    lazy = true,
    keys = { 'za', 'zA' },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('config.lspconfig_config').setup()
    end,
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require 'config.lsp-signature'
    end,
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- LSP Installer
  {
    'williamboman/mason.nvim',
    config = require('config.mason').main,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = require('config.mason').lspconfig,
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    event = { 'BufReadPre', 'BufNewFile' },
  },

  -- nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    branch = 'main',
    config = function()
      require 'config.cmp'
    end,
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp', branch = 'main', lazy = true },
      -- sources
      { 'hrsh7th/cmp-vsnip', branch = 'main' },
      { 'hrsh7th/cmp-buffer', branch = 'main' },
      { 'hrsh7th/cmp-path', branch = 'main' },
      { 'hrsh7th/cmp-cmdline', branch = 'main' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', branch = 'main' },
      { 'hrsh7th/cmp-calc', branch = 'main' },
      'lukas-reineke/cmp-rg',
      'ray-x/cmp-treesitter',
      'andersevenrud/cmp-tmux',
      'hrsh7th/cmp-emoji',
      -- snip
      'hrsh7th/vim-vsnip-integ',
      'hrsh7th/vim-vsnip',
      -- symbols
      'onsails/lspkind-nvim',
      -- etc
      {
        'zbirenbaum/copilot-cmp',
        config = function()
          require('copilot_cmp').setup()
        end,
      },
    },
    lazy = true,
  },
  {
    'mtoohey31/cmp-fish',
    ft = 'fish',
    lazy = true,
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
  {
    'saecki/crates.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    ft = { 'rust', 'toml' },
    config = function()
      require 'config.crates'
    end,
  },
  -- Diagnostic stuff
  {
    'nvimtools/none-ls.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local on_attach = require('config.lspconfig_config').on_attach
      require('config.null-ls').init(on_attach)
    end,
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'folke/trouble.nvim',
    lazy = true,
    cmd = 'Trouble',
    config = function()
      require 'config.trouble'
    end,
    dependencies = 'nvim-tree/nvim-web-devicons',
  },

  -- copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    config = function()
      require 'config.copilot'
    end,
  },

  -- Enhancement
  -- {
  --   'tversteeg/registers.nvim',
  --   config = function()
  --     require('registers').setup()
  --   end,
  --   event = 'VeryLazy',
  -- },
  {
    'sudormrfbin/cheatsheet.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
    lazy = true,
    keys = '<Leader>?',
  },

  { 'mbbill/undotree', lazy = true, cmd = { 'UndotreeToggle' } },

  -- Motions
  { 'machakann/vim-sandwich', lazy = true, keys = 's' },

  -- Tools
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('config.telescope').setup()
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',

      {
        'nvim-telescope/telescope-ui-select.nvim',
        lazy = true,
      },
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        lazy = true,
        version = '*',
      },
    },
    lazy = true,
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require 'config.octo'
    end,
    lazy = true,
    cmd = { 'Octo' },
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('harpoon').setup()
    end,
    lazy = true,
  },
  -- makes some plugins dot-repeatable like leap
  { 'tpope/vim-repeat', event = 'VeryLazy' },

  -- Git
  {
    'tpope/vim-fugitive',
    lazy = true,
    cmd = { 'Git', 'Gvdiffsplit', 'Gclog' },
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'config.gitsigns'
    end,
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  },

  -- Database
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-ui', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  -- Neorg
  {
    'nvim-neorg/neorg',
    version = '~8.7',
    ft = 'norg',
    cmd = { 'Neorg' },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-neorg/neorg-telescope', ft = 'norg' },
      { 'vhyrro/luarocks.nvim' },
    },
    config = function()
      require 'config.neorg'
    end,
  },

  -- Clipboard
  'roxma/vim-tmux-clipboard',

  -- Nvim dev
  { 'bfredl/nvim-luadev', lazy = true, cmd = 'Luadev' },

  -- Justfile
  { 'IndianBoy42/tree-sitter-just', ft = 'just' },
  { 'NoahTheDuke/vim-just', ft = 'just' },

  -- Lang specifics
  {
    'plasticboy/vim-markdown',
    lazy = true,
    ft = { 'markdown' },
    dependencies = 'godlygeek/tabular',
  },
  { 'rust-lang/rust.vim', lazy = true, ft = { 'rust' } },
  {
    'mrcjkb/rustaceanvim',
    version = '*', -- Recommended
    ft = { 'rust' },
    config = function()
      local on_attach = require('config.lspconfig_config').on_attach
      local capabilities = require('config.lspconfig_config').capabilities
      require('config.rustaceanvim').init(on_attach, capabilities)
    end,
    dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' },
  },
  {
    'mfussenegger/nvim-jdtls',
    config = function()
      local on_attach = require('config.lspconfig_config').on_attach
      local capabilities = require('config.lspconfig_config').capabilities
      require('config.jdtls').init(on_attach, capabilities)
    end,
    dependencies = {
      'mfussenegger/nvim-dap',
      'neovim/nvim-lspconfig',
    },
    ft = { 'java' },
  },
  -- {
  --   'elixir-tools/elixir-tools.nvim',
  --   version = '*',
  --   event = { 'BufReadPre', 'BufNewFile' },
  --   config = function()
  --     local on_attach = require('config.lspconfig_config').on_attach
  --     require('config.elixir-tools').init(on_attach)
  --   end,
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  -- },
  {
    'mrcjkb/haskell-tools.nvim',
    version = '*', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      local on_attach = require('config.lspconfig_config').on_attach
      require('config.haskell-tools').init(on_attach)
    end,
  },
  'neovimhaskell/haskell-vim',
  { 'cespare/vim-toml', lazy = true, ft = { 'toml' } },
  { 'stephpy/vim-yaml', lazy = true, ft = { 'yaml', 'yml' } },
  { 'hashivim/vim-terraform', lazy = true, ft = { 'terraform' } },

  -- Util
  -- measure startuptime
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- nvim dev
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        'lazy.nvim',
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
}
