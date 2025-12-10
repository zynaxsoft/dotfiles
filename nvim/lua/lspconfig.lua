local lsp_augroup = vim.api.nvim_create_augroup('LspAttach_group', { clear = true })

local function toggle_inlay(bufnr)
  local cur = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
  vim.lsp.inlay_hint.enable(not cur, { bufnr = bufnr })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_augroup,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    --Enable completion triggered by <c-x><c-o>
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.declaration, bufopts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set({ 'n', 'i' }, '<C-s>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set({ 'n', 'i', 'v' }, '<C-e>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>m', function()
      -- vim.lsp.buf.format { async = true }
      require("conform").format({ async = true, lsp_format = "last" })
    end, bufopts)
    vim.keymap.set('n', '<leader>ii', function()
      toggle_inlay(bufnr)
    end, bufopts)

    -- Semantic highlighting
    ---@diagnostic disable-next-line: need-check-nil
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
  end,
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-l>', function()
  vim.diagnostic.open_float { source = true }
end, opts)
vim.keymap.set('n', '<C-k>', function()
  vim.diagnostic.jump { count = -1, float = { source = true } }
end, opts)
vim.keymap.set('n', '<C-j>', function()
  vim.diagnostic.jump { count = 1, float = { source = true } }
end, opts)

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '😡',
      [vim.diagnostic.severity.WARN] = '🤔',
      [vim.diagnostic.severity.INFO] = '💡',
      [vim.diagnostic.severity.HINT] = '👌',
    },
  },
}

local home = os.getenv 'HOME'
local elixirls_path = home .. '/.local/share/nvim/mason/bin/elixir-ls'
vim.lsp.config('elixirls', {
  cmd = { elixirls_path },
})

-- For LSP servers that don't need extra config
local servers = {
  'taplo',
  'lua_ls',
  'cssls',
  'vtsls',
  'tailwindcss',
  'prismals',
  'terraformls',
  'elixirls',
  'gopls',
  'pyright',
  'vuels',
  'eslint',
  'kotlin_language_server',
  'zls',
  'hls',
}
vim.lsp.enable(servers)
vim.lsp.config('*', {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

vim.diagnostic.config {
  virtual_text = false,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '😡',
      [vim.diagnostic.severity.WARN] = '🤔',
      [vim.diagnostic.severity.INFO] = '💡',
      [vim.diagnostic.severity.HINT] = '👌',
    },
  },
}
