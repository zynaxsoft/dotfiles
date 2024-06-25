local function init(on_attach_init)
  local elixir = require 'elixir'
  local elixirls = require 'elixir.elixirls'

  elixir.setup {
    -- nextls = { enable = true },
    -- credo = {},
    elixirls = {
      enable = true,
      settings = elixirls.settings {
        dialyzerEnabled = false,
        enableTestLenses = false,
      },
      on_attach = function(client, bufnr)
        vim.keymap.set('n', '<space>fp', ':ElixirFromPipe<cr>', { buffer = true, noremap = true })
        vim.keymap.set('n', '<space>tp', ':ElixirToPipe<cr>', { buffer = true, noremap = true })
        vim.keymap.set(
          'v',
          '<space>em',
          ':ElixirExpandMacro<cr>',
          { buffer = true, noremap = true }
        )
      end,
    },
  }
end

return {
  init = init,
}
