require('blink.cmp').setup {
  keymap = {
    preset = 'default',        -- ← this already gives you 100% of your old mappings:
                               --   <C-n> = select_next
                               --   <C-p> = select_prev
                               --   <C-b> = scroll docs up
                               --   <C-f> = scroll docs down
                               --   <C-y> = accept/confirm
                               --   <C-e> = manual show (no debug print anymore)
  },

  completion = {
    menu = { auto_show = true },
    documentation = { auto_show = true },
    -- keep your old completeopt feel
    completeopt = 'menu,menuone,noselect',
  },

  sources = {
    default = { 'lsp', 'path', 'snippets' },   -- ← 'snippets' enables native vim.snippet
  },

  snippets = {
    preset = 'default',   -- uses Neovim 0.12's built-in vim.snippet engine
  },

  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
}
