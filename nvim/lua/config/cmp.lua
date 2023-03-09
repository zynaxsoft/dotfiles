local cmp = require 'cmp'
cmp.setup {
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  mapping = {
    -- Tab immediately completes. C-n/C-p to select.
    ['<Tab>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior },
    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior },
    ['<CR>'] = cmp.mapping.confirm {
      -- behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim-lsp-signature-help' },
    { name = 'vsnip' },
  }, {
    { name = 'emoji', option = { insert = true } },
    { name = 'fish' },
    { name = 'path' },
    { name = 'crates' },
  }, {
    { name = 'treesitter', keyword_length = 3 },
    { name = 'buffer', keyword_length = 3 },
    { name = 'calc', keyword_length = 3 },
  }, {
    {
      name = 'rg',
      keyword_length = 3,
      option = {
        additional_arguments = '--one-file-system ' .. '--ignore-file ~/dotfiles/nvim/ignore.rg',
      },
    },
    {
      name = 'tmux',
      keyword_length = 3,
      option = {
        all_panes = false,
        label = '[tmux]',
        trigger_characters = { '.' },
        trigger_characters_ft = {}, -- { filetype = { '.' } }
      },
    },
  }),
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = require('lspkind').cmp_format {
      with_text = true,
      max_width = 50,
      menu = {
        buffer = '[Buf]',
        nvim_lsp = '[LSP]',
        vsnip = '[Snip]',
        treesitter = '[Tree]',
        rg = '[Rg]',
        ['nvim-lsp-signature-help'] = '[Sig]',
        tmux = '[Tmux]',
        calc = '[Calc]',
        path = '[Path]',
        crates = '[Crates]',
        fish = '[Fish]',
      },
      before = function(entry, vim_item)
        return vim_item
      end,
    },
  },
}

cmdline_mapping = {
  ['<CR>'] = {
    c = function(fallback)
      if cmp.visible() and cmp.get_selected_entry() then
        cmp.confirm()
      else
        fallback()
      end
    end,
  },
  -- ['<C-Space>'] = {
  --   c = function(fallback)
  --     local cmp = require 'cmp'
  --     cmp.confirm()
  --   end,
  -- },
  ['<Tab>'] = {
    c = function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        feedkeys.call(keymap.t '<C-z>', 'n')
      end
    end,
  },
  ['<S-Tab>'] = {
    c = function()
      if cmp.visible() then
        cmp.select_prev_item()
      else
        feedkeys.call(keymap.t '<C-z>', 'n')
      end
    end,
  },
  -- ["<C-n>"] = {
  --   c = function(fallback)
  --     local cmp = require("cmp")
  --     if cmp.visible() then
  --       cmp.select_prev_item() -- reversed for the wildmenu
  --     else
  --       fallback()
  --     end
  --   end,
  -- },
  -- ["<C-p>"] = {
  --   c = function(fallback)
  --     local cmp = require("cmp")
  --     if cmp.visible() then
  --       cmp.select_next_item() -- reversed for the wildmenu
  --     else
  --       fallback()
  --     end
  --   end,
  -- },
  ['<C-e>'] = {
    c = cmp.mapping.close(),
  },
}

-- Enable completing paths in /
cmp.setup.cmdline('/', {
  mapping = cmdline_mapping,
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'buffer' } }),
  view = {
    entries = { name = 'wildmenu', separator = '|' },
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  mapping = cmdline_mapping,
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
  view = {
    entries = { name = 'wildmenu', separator = '|' },
  },
})
