local telescope = require('telescope')
local sorters = require('telescope.sorters')
local builtin = require('telescope.builtin')


telescope.setup {
  defaults = {
    file_ignore_patterns = { 'node_modules' },
    sorting_strategy = "ascending",
  },
  extensions = {
    ['ui-select'] = require('telescope.themes').get_dropdown(),
  },
  pickers = {
    lsp_references = {
      initial_mode = "normal",
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.55,
      },
      path_display = { "smart" },
      sorter = sorters.get_fzy_sorter(),
    },

    lsp_definitions = {
      initial_mode = "normal",
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.55,
      },
      sorter = sorters.get_fzy_sorter(),
    },

    lsp_implementations = {
      initial_mode = "normal",
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.55,
      },
      sorter = sorters.get_fzy_sorter(),
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

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
