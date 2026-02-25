-- Non-plugin keymaps
local map = vim.keymap.set

-- Clear search highlight
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic quickfix
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- Exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Better window navigation (NOTE: <C-h/j/k/l> are used by harpoon, use <C-w> prefix instead)
map('n', '<C-w>h', '<C-w><C-h>', { desc = 'Move focus left' })
map('n', '<C-w>l', '<C-w><C-l>', { desc = 'Move focus right' })
map('n', '<C-w>j', '<C-w><C-j>', { desc = 'Move focus down' })
map('n', '<C-w>k', '<C-w><C-k>', { desc = 'Move focus up' })

-- Move lines in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Keep cursor centered when scrolling
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Keep cursor centered when searching
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- vim: ts=2 sts=2 sw=2 et
