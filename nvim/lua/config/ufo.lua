local ftMap = {
  -- vim = 'indent',
  -- git = '',
}
require('ufo').setup {
  open_fold_hl_timeout = 150,
  close_fold_kinds = { },
  preview = {
    win_config = {
      border = { '', '─', '', '', '', '─', '', '' },
      winhighlight = 'Normal:Folded',
      winblend = 0,
    },
    mappings = {
      scrollU = '<C-u>',
      scrollD = '<C-d>',
      jumpTop = '[',
      jumpBot = ']',
    },
  },
  provider_selector = function(bufnr, filetype, buftype)
    -- if you prefer treesitter provider rather than lsp,
    -- return ftMap[filetype] or {'treesitter', 'indent'}
    return ftMap[filetype]
    -- refer to ./doc/example.lua for detail
  end,
}
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zf', function(n)
    require('ufo').openFoldsExceptKinds()
    require('ufo').closeFoldsWith(n)
end)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'zk', function()
  require('ufo').peekFoldedLinesUnderCursor()
end)
