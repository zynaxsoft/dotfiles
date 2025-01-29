local opts = {
  snippets = { preset = 'luasnip' },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  signature = { enabled = true },
  completion = {
    menu = {
      draw = {
        -- columns = { { 'label', 'label_description', gap = 1}, { 'kind_icon', 'kind', gap = 1}, {'source_name' } },
        columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
      },
    },
    documentation = { auto_show = true, auto_show_delay_ms = 0 },
    ghost_text = { enabled = true },
    keyword = { range = 'full' },
    list = { selection = { preselect = true, auto_insert = false } },
  },
  keymap = { preset = 'enter' },
}
return { opts = opts }
