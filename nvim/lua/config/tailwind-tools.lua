function get_opts()
  ---@type TailwindTools.Option
  local opts = {
    server = {
      override = true, -- setup the server from the plugin if true
      settings = {}, -- shortcut for `settings.tailwindCSS`
      on_attach = function(client, buffer) end, -- callback triggered when the server attaches to a buffer
    },
    document_color = {
      enabled = true, -- can be toggled by commands
      kind = 'inline', -- "inline" | "foreground" | "background"
      inline_symbol = '󰝤 ', -- only used in inline mode
      debounce = 200, -- in milliseconds, only applied in insert mode
    },
    conceal = {
      enabled = false, -- can be toggled by commands
      min_length = nil, -- only conceal classes exceeding the provided length
      symbol = '󱏿', -- only a single character is allowed
      highlight = { -- extmark highlight options, see :h 'highlight'
        fg = '#38BDF8',
      },
    },
    cmp = {
      highlight = 'foreground', -- color preview style, "foreground" | "background"
    },
    telescope = {
      utilities = {
        callback = function(name, class) end, -- callback used when selecting an utility class in telescope
      },
    },
    -- see the extension section to learn more
    extension = {
      queries = {}, -- a list of filetypes having custom `class` queries
      patterns = { -- a map of filetypes to Lua pattern lists
        -- exmaple:
        -- rust = { "class=[\"']([^\"']+)[\"']" },
        -- javascript = { "clsx%(([^)]+)%)" },
      },
    },
  }
  return opts
end

return { get_opts = get_opts }
