return {
  -- Harpoon v2
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        '<leader>a',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'Harpoon add file',
      },
      {
        '<leader>h',
        function()
          local harpoon = require('harpoon')
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Harpoon menu',
      },
      {
        '<leader>1',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'Harpoon file 1',
      },
      {
        '<leader>2',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'Harpoon file 2',
      },
      {
        '<leader>3',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'Harpoon file 3',
      },
      {
        '<leader>4',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'Harpoon file 4',
      },
    },
    config = function()
      require('harpoon'):setup()
    end,
  },

  -- Oil.nvim - filesystem editing
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        '<leader>e',
        function()
          local oil = require('oil')
          if vim.bo.filetype == 'oil' then
            oil.close()
          else
            oil.open(vim.fn.getcwd())
          end
        end,
        desc = 'Toggle file explorer (cwd)',
      },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-s>'] = 'actions.select_split',
        ['<C-t>'] = 'actions.select_tab',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['gs'] = 'actions.change_sort',
        ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
        ['q'] = 'actions.close',
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
