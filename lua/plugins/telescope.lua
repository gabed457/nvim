return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable('make') == 1
        end,
      },
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('telescope').setup({
        defaults = {
          file_ignore_patterns = { 'node_modules', '.git/', 'dist/', 'build/' },
        },
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      })

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Live grep' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Buffers' })
      vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = 'Document symbols' })
      vim.keymap.set('n', '<leader>sS', builtin.lsp_dynamic_workspace_symbols, { desc = 'Workspace symbols' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Diagnostics' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Resume last search' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help tags' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Grep word under cursor' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = 'Fuzzy search in buffer' })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
