return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-jest',
    },
    keys = {
      {
        '<leader>tt',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run nearest test',
      },
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand('%'))
        end,
        desc = 'Run file tests',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Test summary',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open({ enter = true, auto_close = true })
        end,
        desc = 'Test output',
      },
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-jest')({
            jestCommand = 'npx jest',
            cwd = function()
              return vim.fn.getcwd()
            end,
          }),
        },
      })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
