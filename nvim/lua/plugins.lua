return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- GUI
  use { 'ishan9299/nvim-solarized-lua', as = 'solarized' }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  -- Show indent line
  use 'Yggdroot/indentLine'
  -- Highlight and preview pattern/regex
  use 'markonm/traces.vim'
  -- Color
  use 'norcalli/nvim-colorizer.lua'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use { 'lewis6991/spellsitter.nvim', requires = 'nvim-treesitter/nvim-treesitter' }

  -- Semantic language support
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'ray-x/lsp_signature.nvim'

  -- nvim-cmp
  use {
    'hrsh7th/nvim-cmp',
    branch = 'main',
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
  use 'jose-elias-alvarez/null-ls.nvim'
  use { 'folke/trouble.nvim', opt = true, requires = 'kyazdani42/nvim-web-devicons' }

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
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
  use {
    'nvim-telescope/telescope-ui-select.nvim',
    requires = {
      'nvim-telescope/telescope.nvim',
    },
  }

  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- Tmux stuff
  use 'roxma/vim-tmux-clipboard'

  -- Lang specifics
  use { 'plasticboy/vim-markdown', requires = 'godlygeek/tabular', opt = true, ft = {'markdown'} }
  use {'rust-lang/rust.vim', opt = true, ft = {'rust'}}
  use {'cespare/vim-toml', opt = true, ft = {'toml'}}
  use {'stephpy/vim-yaml', opt = true, ft = {'yaml', 'yml'}}
  use {'hashivim/vim-terraform', opt = true, ft = {'terraform'}}
end)
