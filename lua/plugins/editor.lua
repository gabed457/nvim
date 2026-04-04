return {
  -- Which-key: keybind hints
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = { mappings = true },
      spec = {
        { '<leader>s', group = 'Search' },
        { '<leader>g', group = 'Git' },
        { '<leader>c', group = 'Code' },
        { '<leader>x', group = 'Trouble/Swap' },
        { '<leader>r', group = 'Rename' },
        { '<leader>n', group = 'Neovim' },
      },
    },
  },

  -- Undotree: persistent undo visualization
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Toggle undotree' },
    },
  },

  -- Surround operations
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },

  -- Auto-close brackets/quotes
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local autopairs = require('nvim-autopairs')
      autopairs.setup({})
      -- Integrate with nvim-cmp
      local ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
      if ok then
        local cmp_ok, cmp = pcall(require, 'cmp')
        if cmp_ok then
          cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end
      end
    end,
  },

  -- Comment.nvim
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  -- Trouble: better diagnostics list
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Trouble: Toggle diagnostics' },
      { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Trouble: Buffer diagnostics' },
    },
    opts = {},
  },

  -- Fidget: LSP progress indicator
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },

  -- Auto-session: restore sessions
  {
    'rmagatti/auto-session',
    lazy = false,
    opts = {
      suppressed_dirs = { '~/', '~/Downloads', '/tmp' },
    },
  },

  -- Cloak: hide sensitive values in .env files
  {
    'laytan/cloak.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      cloak_character = '*',
      highlight_group = 'Comment',
      patterns = {
        {
          file_pattern = '.env*',
          cloak_pattern = '=.+',
          replace = nil,
        },
      },
    },
    keys = {
      { '<leader>ct', '<cmd>CloakToggle<CR>', desc = 'Toggle cloak' },
    },
  },

}

-- vim: ts=2 sts=2 sw=2 et
