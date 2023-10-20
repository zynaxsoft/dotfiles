-- https://www.reddit.com/r/neovim/comments/opipij/guide_tips_and_tricks_to_reduce_startup_and/
local disabled_built_ins = {
--  'gzip',
--  'zip',
--  'zipPlugin',
--  'tar',
--  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end
