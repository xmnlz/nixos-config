local diffview = require('diffview')

diffview.setup {}

vim.keymap.set('n', '<leader>dv', '<cmd>DiffviewOpen<CR>', { desc = 'Diffview open' })
vim.keymap.set('n', '<leader>dc', '<cmd>DiffviewClose<CR>', { desc = 'Diffview close' })
vim.keymap.set('n', '<leader>dh', '<cmd>DiffviewFileHistory<CR>', { desc = 'Diffview file history' })
vim.keymap.set('n', '<leader>df', '<cmd>DiffviewFileHistory %<CR>', { desc = 'Diffview current file history' })
