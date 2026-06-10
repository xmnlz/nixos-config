local gitsigns = require('gitsigns')

gitsigns.setup {
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Actions (normal mode)
    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
    map('n', '<leader>hd', gitsigns.diffthis)
    map('n', '<leader>hD', function() gitsigns.diffthis '~' end)
    map('n', '<leader>hq', gitsigns.setqflist)
    map('n', '<leader>hQ', function() gitsigns.setqflist 'all' end)

    -- Actions (visual mode)
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end)
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end)

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>tw', gitsigns.toggle_word_diff)
  end,
}
