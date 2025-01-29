function init(on_attach_in, capabilities)
  ---@type rustaceanvim.Opts
  vim.g.rustaceanvim = {
    ---@type rustaceanvim.tools.Opts
    tools = {
      hover_actions = {
        auto_focus = true,
      },
    },
    -- LSP configuration
    ---@type rustaceanvim.lsp.ClientOpts
    server = {
      on_attach = function(client, bufnr)
        on_attach_in(client, bufnr)
        vim.keymap.set('n', '<C-e>', function()
          vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
          -- or vim.lsp.buf.codeAction() if you don't want grouping.
        end, { silent = true, buffer = bufnr })
      end,
      settings = {
        -- rust-analyzer language server configuration
        ['rust-analyzer'] = {
          completion = {
            capable = {
              snippets = 'add_parenthesis',
            },
          },
          inlayHints = {
            bindingModeHints = { enable = true },
            closureCaptureHints = { enable = true },
            closureReturnTypeHints = { enable = true },
            lifetimeElisionHints = { enable = true },
          },
        },
      },
    },
    -- DAP configuration
    ---@type rustaceanvim.dap.Opts
    dap = {},
  }
end

return {
  init = init,
}
