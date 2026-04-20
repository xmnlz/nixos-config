require('blink.cmp').setup {
  keymap = {
    preset = 'default',
    ['<C-e>'] = { 'show', 'fallback' },
  },

  completion = {
    menu = {
      auto_show = true,
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind" },
        },
      },
    },
    documentation = { auto_show = true },
    trigger = { show_on_keyword = true },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets' },
    providers = {
      lsp = { min_keyword_length = 0 },
      path = { min_keyword_length = 0 },
      snippets = { min_keyword_length = 0 },
    },
  },

  snippets = {
    preset = 'default',
  },

  signature = { enabled = true },

  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
}
