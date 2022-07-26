local mason = {}

function mason.main()
  require('mason').setup()
end

function mason.lspconfig()
  require('mason-lspconfig').setup {
    ensure_installed = {
      'pylint',
      'flake8',
      'black',
      'stylua',
      'rust-analyzer',
    },
    automatic_installation = true,
  }
end

return mason
