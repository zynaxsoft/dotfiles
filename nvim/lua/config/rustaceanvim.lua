function init(on_attach_in, capabilities)
  vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
      hover_actions = {
        auto_focus = true,
      },
    },
    -- LSP configuration
    inlay_hints = {
      highlight = 'NonText',
    },
    server = {
      on_attach = function(client, bufnr)
        on_attach_in(client, bufnr)
        vim.keymap.set('n', '<C-e>', function()
          vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
          -- or vim.lsp.buf.codeAction() if you don't want grouping.
        end, { silent = true, buffer = bufnr })
        require('lsp-inlayhints').on_attach(client, bufnr)
      end,
      settings = {
        -- rust-analyzer language server configuration
        ['rust-analyzer'] = {},
      },
    },
    -- DAP configuration
    dap = {},
  }
end

return {
  init = init,
}
