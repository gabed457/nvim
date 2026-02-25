-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd('TextYankPost', {
  group = augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Resize splits on window resize
autocmd('VimResized', {
  group = augroup('resize-splits', { clear = true }),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- Close some filetypes with q
autocmd('FileType', {
  group = augroup('close-with-q', { clear = true }),
  pattern = { 'help', 'man', 'qf', 'checkhealth', 'dbout' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
  end,
})

-- Auto-detect .bru files
autocmd({ 'BufRead', 'BufNewFile' }, {
  group = augroup('bruno-filetype', { clear = true }),
  pattern = '*.bru',
  callback = function()
    vim.bo.filetype = 'bru'
    vim.bo.commentstring = '// %s'
  end,
})

-- Set SQL commentstring
autocmd('FileType', {
  group = augroup('sql-settings', { clear = true }),
  pattern = 'sql',
  callback = function()
    vim.bo.commentstring = '-- %s'
  end,
})

-- vim: ts=2 sts=2 sw=2 et
