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
