return {
  -- vim-dadbod (database client)
  { 'tpope/vim-dadbod', lazy = true },

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

      -- Preconfigure for MSSQL/Azure SQL via sqlcmd
      -- Users should set connections via env vars or :DBUIAddConnection
      -- Example: sqlcmd://user:pass@server.database.windows.net:1433/dbname
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
