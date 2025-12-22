local opts = {
  dashboard = { enabled = true },
  explorer = { enabled = true },
  input = { enabled = true },
  image = { enabled = false },
  picker = {
    enabled = true,
    win = {
      input = {
        keys = {
          ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
          ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
        },
      }
    },
  },
  scratch = { enabled = true, ft = "markdown" },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  -- statuscolumn = { enabled = true },
}

local buffers_opts = {
  win = {
    input = { keys = { ["<c-d>"] = { "bufdelete", mode = { "n", "i" } }, }, },
    list = { keys = { ["dd"] = "bufdelete" } },
  },
}

local keys = {
  -- Top Pickers & Explorer
  { "<c-p>",      function() Snacks.picker.smart() end,               desc = "Smart Find Files" },
  { "<c-n>",      function() Snacks.picker.buffers(buffers_opts) end, desc = "Buffers" },
  { "<leader>:",  function() Snacks.picker.command_history() end,     desc = "Command History" },
  { "<leader>hn", function() Snacks.picker.notifications() end,       desc = "Notification History" },
  -- { "<c-_>",           function() Snacks.explorer() end,                                       desc = "File Explorer" },
  -- { "<c-/>",           function() Snacks.explorer() end,                                       desc = "File Explorer" },
  -- find
  { "<leader>fb", function() Snacks.picker.buffers() end,             desc = "Buffers" },
  {
    "<leader>fc",
    function()
      Snacks.picker.files { cwd = vim.fn.stdpath("config") }
    end,
    desc = "Find Config File"
  },
  { "<leader>ff",  function() Snacks.picker.files() end,                             desc = "Find Files" },
  { "<leader>fg",  function() Snacks.picker.git_files() end,                         desc = "Find Git Files" },
  { "<leader>fp",  function() Snacks.picker.projects() end,                          desc = "Projects" },
  { "<leader>j",   function() Snacks.picker.recent() end,                            desc = "Recent" },
  -- git
  -- { "<leader>gb",  function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
  -- { "<leader>gl",  function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
  -- { "<leader>gL",  function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
  -- { "<leader>gs",  function() Snacks.picker.git_status() end,                              desc = "Git Status" },
  -- { "<leader>gS",  function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
  -- { "<leader>gd",  function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
  -- { "<leader>gf",  function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
  -- Grep
  { "<leader>sb",  function() Snacks.picker.lines() end,                             desc = "Buffer Lines" },
  { "<leader>g",   function() Snacks.picker.grep { ignored = false, hidden = true } end, desc = "Grep" },
  { "<leader>G",   function() Snacks.picker.grep_buffers() end,                      desc = "Grep Open Buffers" },
  { "<leader>fw",  function() Snacks.picker.grep_word() end,                         desc = "Visual selection or word", mode = { "n", "x" } },
  -- search
  { '<leader>f"',  function() Snacks.picker.registers() end,                         desc = "Registers" },
  { '<leader>f/',  function() Snacks.picker.search_history() end,                    desc = "Search History" },
  { "<leader>sa",  function() Snacks.picker.autocmds() end,                          desc = "Autocmds" },
  { "<leader>sb",  function() Snacks.picker.lines() end,                             desc = "Buffer Lines" },
  { "<leader>sc",  function() Snacks.picker.command_history() end,                   desc = "Command History" },
  { "<leader>fbc", function() Snacks.picker.commands() end,                          desc = "Commands" },
  { "<leader>sd",  function() Snacks.picker.diagnostics() end,                       desc = "Diagnostics" },
  { "<leader>sD",  function() Snacks.picker.diagnostics_buffer() end,                desc = "Buffer Diagnostics" },
  { "<leader>fh",  function() Snacks.picker.help() end,                              desc = "Help Pages" },
  { "<leader>fbh", function() Snacks.picker.highlights() end,                        desc = "Highlights" },
  { "<leader>fi",  function() Snacks.picker.icons() end,                             desc = "Icons" },
  { "<leader>fj",  function() Snacks.picker.jumps() end,                             desc = "Jumps" },
  { "<leader>fe",  function() Snacks.picker.keymaps() end,                           desc = "Keymaps" },
  { "<leader>fl",  function() Snacks.picker.loclist() end,                           desc = "Location List" },
  { "<leader>fm",  function() Snacks.picker.marks() end,                             desc = "Marks" },
  { "<leader>sM",  function() Snacks.picker.man() end,                               desc = "Man Pages" },
  { "<leader>sp",  function() Snacks.picker.lazy() end,                              desc = "Search for Plugin Spec" },
  { "<leader>fq",  function() Snacks.picker.qflist() end,                            desc = "Quickfix List" },
  { "<leader>sR",  function() Snacks.picker.resume() end,                            desc = "Resume" },
  { "<leader>su",  function() Snacks.picker.undo() end,                              desc = "Undo History" },
  { "<leader>uC",  function() Snacks.picker.colorschemes() end,                      desc = "Colorschemes" },
  -- LSP
  { "gd",          function() Snacks.picker.lsp_definitions() end,                   desc = "Goto Definition" },
  { "gD",          function() Snacks.picker.lsp_type_definitions() end,              desc = "Goto Type Definition" },
  { "gi",          function() Snacks.picker.lsp_implementations() end,               desc = "Goto Implementation" },
  { "gr",          function() Snacks.picker.lsp_references() end,                    nowait = true,                     desc = "References" },
  { "gy",          function() Snacks.picker.lsp_declarations() end,                  desc = "Goto Declaration" },
  { "<leader>ss",  function() Snacks.picker.lsp_symbols() end,                       desc = "LSP Symbols" },
  { "<leader>ws",  function() Snacks.picker.lsp_workspace_symbols() end,             desc = "LSP Workspace Symbols" },
  -- Other
  -- { "<leader>z",       function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
  -- { "<leader>Z",       function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
  { "<leader>.",   function() Snacks.scratch() end,                                  desc = "Toggle Scratch Buffer" },
  { "<leader>S",   function() Snacks.scratch.select() end,                           desc = "Select Scratch Buffer" },
  { "<leader>bd",  function() Snacks.bufdelete() end,                                desc = "Delete Buffer" },
  { "<leader>cR",  function() Snacks.rename.rename_file() end,                       desc = "Rename File" },
  { "<leader>fs",  function() Snacks.picker.spelling() end,                          desc = "Spell Suggest" },
  -- { "<leader>gB",  function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
  -- { "<leader>gg",  function() Snacks.lazygit() end,                                        desc = "Lazygit" },
  { "<leader>un",  function() Snacks.notifier.hide() end,                            desc = "Dismiss All Notifications" },
}

local function init()
end

return { opts = opts, keys = keys, init = init }
