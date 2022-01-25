local M = {}

M.project_files = function()
  local file_opts = {
    no_ignore = true,
    hidden = true,
  }
  local git_opts = {
    show_untracked = true,
  }
  local ok = pcall(require"telescope.builtin".git_files, git_opts)
  if not ok then require"telescope.builtin".find_files(file_opts) end
end

return M
