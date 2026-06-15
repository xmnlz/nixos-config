local gitsigns = require('gitsigns')

gitsigns.setup {
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
    end

    map('n', '<leader>bb', gitsigns.blame)
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>go', open_commit)
  end,
}
