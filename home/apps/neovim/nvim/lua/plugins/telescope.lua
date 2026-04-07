require('telescope').setup {
  defaults = {
    file_ignore_patterns = { '/node_modules' },
  },
  extensions = {
    ['ui-select'] = require('telescope.themes').get_dropdown(),
  },
}

-- pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>sf', builtin.find_files)
vim.keymap.set('n', '<leader>sw', builtin.grep_string)
vim.keymap.set('n', '<leader>sg', builtin.live_grep)
vim.keymap.set('n', '<leader>s.', builtin.oldfiles)
vim.keymap.set('n', '<leader><leader>', builtin.buffers)

vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end)
