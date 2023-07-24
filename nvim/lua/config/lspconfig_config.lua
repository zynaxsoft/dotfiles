local on_attach = function(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set({ 'n', 'i' }, '<C-s>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set({ 'n', 'i', 'v' }, '<C-e>', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>m', function()
    vim.lsp.buf.format { async = true }
  end, bufopts)

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
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '<C-l>', function()
    vim.diagnostic.open_float { source = true }
  end, opts)
  vim.keymap.set('n', '<C-k>', function()
    vim.diagnostic.goto_prev { float = { source = true } }
  end, opts)
  vim.keymap.set('n', '<C-j>', function()
    vim.diagnostic.goto_next { float = { source = true } }
  end, opts)

  local signs = { Error = '😡', Warn = '🤔', Hint = '👌', Info = '💡' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

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
  local servers = { 'taplo', 'lua_ls', 'terraformls', 'volar', 'tsserver', 'gopls' }
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
