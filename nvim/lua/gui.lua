if vim.g.neovide == nil then
  return
end
vim.g.myGuiFontSize = 12.5
local function set_font_size(size)
  local font = 'VictorMono NF:h'
  vim.g.myGuiFontSize = size
  vim.opt.guifont = font..size
end
local function my_font_size(up)
  local size = vim.g.myGuiFontSize
  if up then
    set_font_size(size + 0.5)
  else
    set_font_size(size - 0.5)
  end
end
set_font_size(vim.g.myGuiFontSize)

local opts = { noremap = true, silent = true }
-- Gui specific keybinds
vim.keymap.set('', '<C-ScrollWheelUp>', function() my_font_size(true) end, opts)
vim.keymap.set('', '<C-ScrollWheelDown>', function() my_font_size(false) end, opts)
vim.keymap.set('', '<a-0>', function() set_font_size(12.5) end, opts)
-- some how mapping <C-_> in the keymaps doesn't work
vim.keymap.set('', '<C-/>', [[<cmd>NvimTreeToggle<cr>]], opts)

-- nvui setup
-- vim.cmd [[
--   cd ~
-- ]]
