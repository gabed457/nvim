-- Non-plugin keymaps
local map = vim.keymap.set

-- Clear search highlight
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic quickfix
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- Exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Better window navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })

-- Move lines in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Keep cursor centered when scrolling
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Keep cursor centered when searching
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Update Neovim config from remote
map('n', '<leader>nu', function()
  local config_dir = vim.fn.stdpath('config')
  vim.notify('Updating Neovim config...', vim.log.levels.INFO)
  vim.fn.jobstart({ 'git', '-C', config_dir, 'pull', 'origin', 'main' }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_exit = function(_, code)
      vim.schedule(function()
        if code == 0 then
          vim.notify('Config updated! Restart Neovim to apply changes.', vim.log.levels.INFO)
        else
          vim.notify('Config update failed (exit code ' .. code .. ')', vim.log.levels.ERROR)
        end
      end)
    end,
  })
end, { desc = 'Update Neovim config' })

-- vim: ts=2 sts=2 sw=2 et
