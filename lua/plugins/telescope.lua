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
    keys = {
      { '<leader>sf', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
      { '<leader>sg', function() require('telescope.builtin').live_grep() end, desc = 'Live grep' },
      { '<leader>sb', function() require('telescope.builtin').buffers() end, desc = 'Buffers' },
      { '<leader>ss', function() require('telescope.builtin').lsp_document_symbols() end, desc = 'Document symbols' },
      { '<leader>sS', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, desc = 'Workspace symbols' },
      { '<leader>sd', function() require('telescope.builtin').diagnostics() end, desc = 'Diagnostics' },
      { '<leader>sk', function() require('telescope.builtin').keymaps() end, desc = 'Keymaps' },
      { '<leader>sr', function() require('telescope.builtin').resume() end, desc = 'Resume last search' },
      { '<leader>sh', function() require('telescope.builtin').help_tags() end, desc = 'Help tags' },
      { '<leader>sw', function() require('telescope.builtin').grep_string() end, desc = 'Grep word under cursor' },
      { '<leader><leader>', function() require('telescope.builtin').buffers() end, desc = 'Open buffers' },
      {
        '<leader>/',
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = 'Fuzzy search in buffer',
      },
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
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
