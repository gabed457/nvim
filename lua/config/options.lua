-- Options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Disable netrw (oil.nvim replaces it)
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'

opt.mouse = 'a'
opt.showmode = false
opt.breakindent = true
opt.undofile = true
opt.undodir = vim.fn.stdpath('data') .. '/undo'

opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 250
opt.timeoutlen = 300

opt.splitright = true
opt.splitbelow = true

opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

opt.inccommand = 'split'
opt.cursorline = true
opt.scrolloff = 10
opt.confirm = true

opt.termguicolors = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.wrap = false
opt.swapfile = false
opt.backup = false

-- Persistent undo
opt.undolevels = 10000

-- Sync clipboard
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- vim: ts=2 sts=2 sw=2 et
