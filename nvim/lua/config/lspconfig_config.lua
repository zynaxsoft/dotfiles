local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<C-e>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('i', '<C-e>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<C-e>', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  buf_set_keymap('n', '<C-l>', '<cmd>lua vim.diagnostic.open_float{source=true}<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.diagnostic.goto_prev{float={source=true}}<CR>', opts)
  buf_set_keymap('n', '<C-j>', '<cmd>lua vim.diagnostic.goto_next{float={source=true}}<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>m', '<cmd>lua vim.lsp.buf.format {async = true} <CR>', opts)

  local signs = { Error = '😡', Warn = '🤔', Hint = '👌', Info = '💡' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Semantic highlighting
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      hi LspReferenceRead guibg=#363a4f gui=NONE
      hi LspReferenceText guibg=#363a4f gui=NONE
      hi LspReferenceWrite guibg=#363a4f gui=NONE
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

function setup()
  local lspconfig = require 'lspconfig'

  local capabilities =
    require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  lspconfig.ruff_lsp.setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {},
    capabilities = capabilities,
  }

  lspconfig.pyright.setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
        },
      },
    },
    capabilities = capabilities,
  }

  -- ==Moved to config.rust-tools.==
  --
  -- lspconfig.rust_analyzer.setup {
  --   on_attach = on_attach,
  --   flags = {
  --     debounce_text_changes = 150,
  --   },
  --   settings = {
  --     ['rust-analyzer'] = {
  --       cargo = {
  --         allFeatures = true,
  --       },
  --       diagnostics = {
  --         disabled = { 'inactive-code' },
  --       },
  --       -- completion = {
  --       --   postfix = {
  --       --     enable = false,
  --       --   },
  --       -- },
  --     },
  --   },
  --   capabilities = capabilities,
  -- }

  -- For LSP servers that don't need extra config
  local servers = { 'taplo', 'lua_ls', 'terraformls', 'vuels', 'tsserver', 'gopls' }
  local settings = {
    Lua = {
      format = {
        enable = false,
      },
      diagnostics = { globals = { 'vim' } },
    },
  }
  for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
      settings = settings,
    }
  end

  vim.diagnostic.config {
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = true,
    severity_sort = true,
  }
end

return {
  setup = setup,
  on_attach = on_attach,
  capabilities = capabilities,
}
