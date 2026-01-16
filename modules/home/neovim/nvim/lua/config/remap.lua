-- emacs go crazy
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- if i woulde ever use MacOS
vim.keymap.set('v', '<D-c>', '"+y')
vim.keymap.set({ 'n', 'v' }, '<D-v>', '"+p')
vim.keymap.set('i', '<D-v>', '<C-r>+')

-- cool text shift macro
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set({ 'n', 'i' }, '<left>', '')
vim.keymap.set({ 'n', 'i' }, '<right>', '')
vim.keymap.set({ 'n', 'i' }, '<up>', '')
vim.keymap.set({ 'n', 'i' }, '<down>', '')
