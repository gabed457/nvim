return {
  -- Gitsigns
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = 'Git: ' .. desc })
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gs.nav_hunk('next')
          end
        end, 'Next hunk')
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end, 'Previous hunk')

        -- Actions
        map('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
        map('n', '<leader>gu', gs.undo_stage_hunk, 'Undo stage hunk')
        map('n', '<leader>gr', gs.reset_hunk, 'Reset hunk')
        map('v', '<leader>gs', function()
          gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Stage hunk')
        map('v', '<leader>gr', function()
          gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Reset hunk')
        map('n', '<leader>gS', gs.stage_buffer, 'Stage buffer')
        map('n', '<leader>gR', gs.reset_buffer, 'Reset buffer')
        map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>gb', function()
          gs.blame_line({ full = true })
        end, 'Blame line')
        map('n', '<leader>gd', gs.diffthis, 'Diff this')
      end,
    },
  },

  -- Lazygit integration via terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      {
        '<leader>gg',
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          local lazygit = Terminal:new({
            cmd = 'lazygit',
            direction = 'float',
            float_opts = { border = 'rounded' },
            on_open = function(term)
              vim.cmd('startinsert!')
              vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
            end,
          })
          lazygit:toggle()
        end,
        desc = 'Lazygit',
      },
    },
    opts = {
      open_mapping = false,
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
