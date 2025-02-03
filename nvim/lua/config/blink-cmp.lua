local opts = {
  snippets = { preset = 'luasnip' },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
  },
  sources = {
    default = {
      'lsp',
      'path',
      'snippets',
      'buffer',
      'emoji',
      'ripgrep',
      'dadbod',
      'dictionary',
      'lazydev',
    },
    providers = {
      emoji = {
        module = 'blink-emoji',
        name = 'Emoji',
        score_offset = 15, -- Tune by preference
        opts = { insert = true }, -- Insert emoji (default) or complete its name
      },
      ripgrep = { module = 'blink-ripgrep', name = 'Ripgrep' },
      dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
      lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
      dictionary = {
        module = 'blink-cmp-dictionary',
        name = 'Dict',
        min_keyword_length = 3,
        opts = {
          dictionary_files = { vim.fn.expand '~/.config/nvim/dictionary/words.dict' },
        },
      },
    },
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
    list = {
      selection = {
        preselect = function(ctx)
          return ctx.mode ~= 'cmdline'
        end,
        auto_insert = false,
      },
    },
  },
  keymap = { preset = 'enter' },
}

return { opts = opts }
