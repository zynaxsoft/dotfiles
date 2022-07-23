local null_ls = require("null-ls")

null_ls.setup({
  on_attach = on_attach,
  sources = {
    -- Formatting
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--indent-type", "Spaces", "--column-width", "100", "--indent-width", "2", "--call-parentheses", "None", "--quote-style", "AutoPreferSingle" },
    }),
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
    -- null_ls.builtins.diagnostics.selene,
    -- null_ls.builtins.diagnostics.luacheck,

    -- Code actions
    -- null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.eslint_d,
  },
})

