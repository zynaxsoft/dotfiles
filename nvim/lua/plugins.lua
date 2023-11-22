return {
  -- Core
  'nvim-lua/plenary.nvim',

  -- GUI
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require 'config.catppuccin'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'config.lualine'
    end,
    dependencies = { 'arkav/lualine-lsp-progress', 'nvim-tree/nvim-web-devicons' },
  },

  -- Show indent line
  -- 'Yggdroot/indentLine'
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require 'config.indent-blankline'
    end,
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },

  -- Highlight and preview pattern/regex
  {
    'markonm/traces.vim',
    event = 'VeryLazy',
  },

  -- Color
  'norcalli/nvim-colorizer.lua',

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = require('config.treesitter').main,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    commit = "1ba937b38eb101e37be120087a6a513137986c63",
    config = require('config.treesitter').context,
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = require('config.treesitter').textobjects,
    dependencies = 'nvim-treesitter/nvim-treesitter',
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

  -- Folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      require 'config.ufo'
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('config.lspconfig_config').setup()
    end,
  },
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require 'config.lsp-signature'
    end,
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
  },

  -- nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    branch = 'main',
    config = function()
      require 'config.cmp'
    end,
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp', branch = 'main' },
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
    },
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
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local on_attach = require('config.lspconfig_config').on_attach
      require('config.null-ls').init(on_attach)
    end,
  },
  {
    'folke/trouble.nvim',
    lazy = true,
    cmd = 'TroubleToggle',
    config = function()
      require 'config.trouble'
    end,
    dependencies = 'nvim-tree/nvim-web-devicons',
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

  'mbbill/undotree',

  -- Motions
  { 'machakann/vim-sandwich', lazy = true, keys = 's' },

  -- Tools
  {
    'nvim-telescope/telescope.nvim',
    config = require('config.telescope').setup,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    commit = 'b0015e6e4b46a',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
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
    event = 'VeryLazy',
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
  },

  -- Clipboard
  'roxma/vim-tmux-clipboard',
  { 'ojroques/nvim-osc52', config = require('config.osc52').init },

  -- Nvim dev
  { 'bfredl/nvim-luadev', lazy = true, cmd = 'Luadev' },

  -- Lang specifics
  {
    'plasticboy/vim-markdown',
    lazy = true,
    ft = { 'markdown' },
    dependencies = 'godlygeek/tabular',
  },
  { 'rust-lang/rust.vim', lazy = true, ft = { 'rust' } },
  {
    'simrat39/rust-tools.nvim',
    -- lazy = true,
    -- ft = { 'rust' },
    config = function()
      local on_attach = require('config.lspconfig_config').on_attach
      local capabilities = require('config.lspconfig_config').capabilities
      require('config.rust-tools').init(on_attach, capabilities)
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
      'neovim/nvim-lspconfig',
    },
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
}
