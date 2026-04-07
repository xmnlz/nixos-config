-- Set <leader> and <localleader> keys to <Space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- nerd font
vim.g.have_nerd_font = true

-- inline errors
vim.diagnostic.config {
  virtual_text = true,
}

vim.opt.winborder = 'rounded'

-- Indentation
vim.opt.tabstop = 2 -- A tab character appears as 2 spaces
vim.opt.shiftwidth = 2 -- Indentation uses 2 spaces
vim.opt.expandtab = true -- Convert tabs to spaces
vim.bo.softtabstop = 2 -- Number of spaces a <Tab> inserts in insert mode

-- Files and Backup
vim.opt.autoread = true -- Reload file if changed outside of Neovim
vim.opt.swapfile = false -- Disable swap files to avoid clutter

-- Line Numbers
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers

--  UI & Display
vim.opt.cursorline = true -- Highlight the current line
vim.opt.signcolumn = 'yes' -- Always show the sign column (for Git, LSP signs)
vim.opt.scrolloff = 15 -- Keep 15 lines above/below cursor visible

--  Mouse & Clipboard
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard for all operations

vim.opt.breakindent = true -- Maintain indent on wrapped lines
vim.opt.undofile = true -- Enable persistent undo

vim.opt.ignorecase = true -- Case-insensitive search by default
vim.opt.smartcase = true -- But case-sensitive if pattern has uppercase

vim.opt.updatetime = 250 -- Faster update for diagnostics (CursorHold delay)
vim.opt.timeoutlen = 300 -- Short timeout for mapped sequences (like <leader>)

vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below

vim.opt.list = false -- Don't show whitespace characters by default
