return {
  -- vim-dadbod (database client)
  {
    'tpope/vim-dadbod',
    lazy = true,
    config = function()
      -- Override sqlserver adapter to add -W (trim trailing column whitespace).
      -- Without this, sqlcmd pads columns to their declared schema width
      -- (e.g. NVARCHAR(255) = 255 chars wide), making output unreadable.
      vim.cmd([[
        call db#adapter#sqlserver#canonicalize('sqlserver://x')
        let s:db_orig_interactive = funcref('db#adapter#sqlserver#interactive')
        function! db#adapter#sqlserver#interactive(url) abort
          return s:db_orig_interactive(a:url) + ['-W']
        endfunction
      ]])
    end,
  },

  -- Dadbod UI
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      'tpope/vim-dadbod',
      'kristijanhusak/vim-dadbod-completion',
    },
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    keys = {
      { '<leader>Du', '<cmd>DBUIToggle<CR>', desc = 'Toggle Dadbod UI' },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_adapter_sqlserver_args = { '-G' }

      -- Preconfigure for MSSQL/Azure SQL via sqlserver adapter (uses sqlcmd CLI)
      -- Users should set connections via env vars or :DBUIAddConnection
      -- Example: sqlserver://server.database.windows.net:1433/dbname (uses AD auth via -G flag)
      vim.g.db_ui_save_location = vim.fn.stdpath('data') .. '/db_ui'

      -- Add dadbod completion to nvim-cmp for SQL buffers
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'sql', 'mysql', 'plsql' },
        callback = function()
          local ok, cmp = pcall(require, 'cmp')
          if ok then
            cmp.setup.buffer({
              sources = {
                { name = 'vim-dadbod-completion' },
                { name = 'buffer' },
              },
            })
          end
        end,
      })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
