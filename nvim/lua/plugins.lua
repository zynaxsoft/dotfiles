return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- GUI
  use { 'ishan9299/nvim-solarized-lua', as = 'solarized' }
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'config.lualine'
    end,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  -- Show indent line
  -- use 'Yggdroot/indentLine'
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require 'config.indent-blankline'
    end,
    requires = 'nvim-treesitter/nvim-treesitter',
  }

  -- Highlight and preview pattern/regex
  use 'markonm/traces.vim'

  -- Color
  use 'norcalli/nvim-colorizer.lua'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = (require 'config.treesitter').main,
  }
  use {
    'lewis6991/spellsitter.nvim',
    config = (require 'config.treesitter').spell,
    requires = 'nvim-treesitter/nvim-treesitter',
  }
  use {
    'nvim-treesitter/nvim-treesitter-context',
    config = (require 'config.treesitter').context,
    requires = 'nvim-treesitter/nvim-treesitter',
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = (require 'config.treesitter').textobjects,
    requires = 'nvim-treesitter/nvim-treesitter',
  }

  -- Tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    cmd = 'NvimTreeToggle',
    config = function()
      require 'config.nvim-tree'
    end,
    opt = true,
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
  }

  -- Semantic language support
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require 'lspconfig'
    end,
  }
  use 'nvim-lua/lsp_extensions.nvim'
  use 'ray-x/lsp_signature.nvim'

  -- nvim-cmp
  use {
    'hrsh7th/nvim-cmp',
    branch = 'main',
    config = function()
      require 'config.cmp'
    end,
    requires = {
      { 'hrsh7th/cmp-nvim-lsp', branch = 'main' },
      -- sources
      { 'hrsh7th/cmp-vsnip', branch = 'main' },
      { 'hrsh7th/cmp-buffer', branch = 'main' },
      { 'hrsh7th/cmp-path', branch = 'main' },
      { 'hrsh7th/cmp-cmdline', branch = 'main' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', branch = 'main' },
      { 'hrsh7th/cmp-calc', branch = 'main' },
      { 'saecki/crates.nvim', branch = 'main' },
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
  }
  -- Diagnostic stuff
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'config.null-ls'
    end,
  }
  use {
    'folke/trouble.nvim',
    opt = true,
    cmd = 'TroubleToggle',
    config = function()
      require 'config.trouble'
    end,
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- Enhancement
  use { 'tversteeg/registers.nvim', branch = 'main' }
  use {
    'sudormrfbin/cheatsheet.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
  }

  -- Motions
  use 'tpope/vim-surround'
  use 'justinmk/vim-sneak'
  use 'machakann/vim-sandwich'

  -- Tools
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'config.telescope'
    end,
    requires = { 'nvim-lua/plenary.nvim' },
  }
  use {
    'nvim-telescope/telescope-ui-select.nvim',
    requires = {
      'nvim-telescope/telescope.nvim',
    },
  }

  -- Git
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'config.gitsigns'
    end,
  }

  -- Tmux stuff
  use 'roxma/vim-tmux-clipboard'

  -- Lang specifics
  use {
    'plasticboy/vim-markdown',
    opt = true,
    ft = { 'markdown' },
    requires = 'godlygeek/tabular',
  }
  use { 'rust-lang/rust.vim', opt = true, ft = { 'rust' } }
  use { 'cespare/vim-toml', opt = true, ft = { 'toml' } }
  use { 'stephpy/vim-yaml', opt = true, ft = { 'yaml', 'yml' } }
  use { 'hashivim/vim-terraform', opt = true, ft = { 'terraform' } }
end)
