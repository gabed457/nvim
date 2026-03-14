return {
  -- vim-dadbod (database client)
  {
    'tpope/vim-dadbod',
    lazy = true,
    config = function()
      -- Override sqlserver adapter to add:
      --   -G  Azure AD / Entra ID interactive auth (personal login, no SQL password)
      --   -W  Trim trailing column whitespace (sqlcmd pads to schema width otherwise)
      vim.cmd([[
        call db#adapter#sqlserver#canonicalize('sqlserver://x')
        let s:db_orig_interactive = funcref('db#adapter#sqlserver#interactive')
        function! db#adapter#sqlserver#interactive(url) abort
          return s:db_orig_interactive(a:url) + ['-G', '-W']
        endfunction
        let s:db_orig_input = funcref('db#adapter#sqlserver#input')
        function! db#adapter#sqlserver#input(url, in) abort
          return s:db_orig_input(a:url, a:in) + ['-G', '-W']
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
      -- Azure SQL connections use Entra ID personal auth (-G flag injected in adapter override)
      -- Add connections via :DBUIAddConnection with URL: sqlserver://server.database.windows.net:1433/dbname
      -- No username/password needed — sqlcmd will prompt for Azure AD interactive login
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
