-- LSP configuration
local cmp = require'cmp'

local lspconfig = require'lspconfig'
cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- Tab immediately completes. C-n/C-p to select.
    ['<Tab>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior }),
    ['<CR>'] = cmp.mapping.confirm {
      -- behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  },
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
      { name = 'rg'},
      { name = 'treesitter'},
      { name = 'tmux', option = {
        all_panes = false,
        label = '[tmux]',
        trigger_characters = { '.' },
        trigger_characters_ft = {} -- { filetype = { '.' } }
      }},
      { name = 'nvim-lsp-signature-help' },
      { name = 'calc' },
    },
    {{ name = 'emoji', option = { insert = true } }},
    {{ name = 'path' }},
    {{ name = 'crates' }}
  ),
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = require'lspkind'.cmp_format({
      with_text = true,
      max_width = 50,
      menu = ({
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        vsnip = "[Snip]",
        treesitter = "[Tree]",
        rg = "[Rg]",
        ["nvim-lsp-signature-help"] = "[Sig]",
        tmux = "[Tmux]",
        calc = "[Calc]",
        path = "[Path]",
        crates = "[Crates]",
      }),
      before = function (entry, vim_item)
        return vim_item
      end,
    })
  },
})

cmdline_mapping = {
    ['<CR>'] = {
      c = function(fallback)
        local cmp = require('cmp')
        if cmp.visible() and cmp.get_selected_entry() then
          cmp.confirm()
        else
          fallback()
        end
      end,
    },
    ['<C-Space>'] = {
      c = function(fallback)
        local cmp = require('cmp')
        cmp.complete()
      end,
    },
    ['<Tab>'] = {
      c = function()
        local cmp = require('cmp')
        if cmp.visible() then
          cmp.select_next_item()
        else
          feedkeys.call(keymap.t('<C-z>'), 'n')
        end
      end,
    },
    ['<S-Tab>'] = {
      c = function()
        local cmp = require('cmp')
        if cmp.visible() then
          cmp.select_prev_item()
        else
          feedkeys.call(keymap.t('<C-z>'), 'n')
        end
      end,
    },
    ['<C-n>'] = {
      c = function(fallback)
        local cmp = require('cmp')
        if cmp.visible() then
          cmp.select_prev_item()  -- reversed for the wildmenu
        else
          fallback()
        end
      end,
    },
    ['<C-p>'] = {
      c = function(fallback)
        local cmp = require('cmp')
        if cmp.visible() then
          cmp.select_next_item()  -- reversed for the wildmenu
        else
          fallback()
        end
      end,
    },
    ['<C-e>'] = {
      c = cmp.mapping.close(),
    },
  }

-- Enable completing paths in /
cmp.setup.cmdline('/', {
  mapping = cmdline_mapping,
  sources = cmp.config.sources(
    {{ name = 'path' }},
    {{ name = 'buffer' }}
  ),
  view = {
    entries = {name = 'wildmenu', separator = '|' }
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  mapping = cmdline_mapping,
  sources = cmp.config.sources(
    {{ name = 'path' }},
    {{ name = 'cmdline' }}
  ),
  view = {
    entries = {name = 'wildmenu', separator = '|' }
  },
})

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<C-e>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('i', '<C-e>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<C-e>', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  buf_set_keymap('n', '<C-l>', '<cmd>lua vim.diagnostic.open_float{source=true}<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.diagnostic.goto_prev{float={source=true}}<CR>', opts)
  buf_set_keymap('n', '<C-j>', '<cmd>lua vim.diagnostic.goto_next{float={source=true}}<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap("n", "<leader>m", "<cmd>lua vim.lsp.buf.format {async = true} <CR>", opts)

  local signs = { Error = "😡", Warn = "🤔", Hint = "👌", Info = "💡" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    bind = true,
    -- doc_lines = 0,
    handler_opts = {
      border = "rounded"
    },
    hi_parameter = "LspSignatureActiveParameter",
  })
  -- Semantic highlighting
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      hi LspReferenceRead guibg=#073642 gui=NONE
      hi LspReferenceText guibg=#073642 gui=NONE
      hi LspReferenceWrite guibg=#073642 gui=NONE
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.pyright.setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      diagnostics = {
        disabled = {"inactive-code"},
      },
      -- completion = {
      --   postfix = {
      --     enable = false,
      --   },
      -- },
    },
  },
  capabilities = capabilities,
}

-- For LSP servers that don't need extra config
local servers = { 'taplo' }
for _, lsp in pairs(servers) do
require('lspconfig')[lsp].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  }
}
end

vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  signs = true,
  update_in_insert = true,
  severity_sort = true,
})

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = false,
--     underline = true,
--     signs = true,
--     update_in_insert = true,
--   }
-- )

require("trouble").setup {
  signs = {
    -- icons / text used for a diagnostic
    error = "😡",
    warning = "🤔",
    hint = "👌",
    information = "💡",
    other = "✔"
  },
}

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Formatting
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.taplo,

    -- Completion
    -- null_ls.builtins.completion.spell,

    -- Diagnostic
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.eslint,
    -- python
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.flake8,
    -- lua
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.luacheck,

    -- Code actions
    -- null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.eslint_d,
  },
})

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    initial_mode = "insert",
    winblend = 15,
    layout_strategy = 'vertical',
    layout_config = {
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim"
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
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    }
  }
}
require("telescope").load_extension("ui-select")

function gitsigns_visual_op(op)
  return require('gitsigns')[op]({ vim.fn.line("."), vim.fn.line("v") })
end

require('gitsigns').setup {
  signs = {
    add = {hl = 'GitSignsAdd', text = '+', numhl='GitSignsAddNr', linehl='GitSignsAddLn'},
    change = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete= {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete= {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 50,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

    -- Actions
    map('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
    map('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
    map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    -- from https://github.com/b0o/nvim-conf/blob/main/lua/user/mappings.lua#L716
    map('v', '<leader>hs', '<cmd>lua gitsigns_visual_op"stage_hunk"<CR>')
    map('v', '<leader>hr', '<cmd>lua gitsigns_visual_op"reset_hunk"<CR>')
    map('v', '<leader>hu', '<cmd>lua gitsigns_visual_op"undo_stage_hunk"<CR>')
    map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
    map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

    -- Text object                                        
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

require('spellsitter').setup {
  -- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
  enable = true,
}

require('crates').setup()
require'colorizer'.setup()

require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
        },
        -- Example for a specific filetype.
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        --   rust = {
        --       'impl_item',
        --   },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
}
