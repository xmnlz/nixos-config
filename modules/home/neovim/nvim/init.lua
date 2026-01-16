require 'config.options'
require 'config.remap'
require 'config.lsp'
require 'config.lazy'

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('x-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
