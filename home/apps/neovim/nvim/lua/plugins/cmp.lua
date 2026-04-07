local cmp = require 'cmp'
local types = require('cmp.types')

cmp.setup {
  completion = { completeopt = 'menu,menuone,noinsert' },

  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-y>'] = cmp.mapping.confirm { select = true },
    ['<C-l>'] = cmp.mapping.complete(),
  },
  sources = {
    {
      name = 'nvim_lsp',
      entry_filter = function(entry)
        return entry:get_kind() ~= types.lsp.CompletionItemKind.Snippet
      end,
    },
    { name = 'path' },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
}
