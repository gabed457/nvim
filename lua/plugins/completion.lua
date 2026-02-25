return {
  -- Snippet engine
  {
    'L3MON4D3/LuaSnip',
    version = '2.*',
    build = 'make install_jsregexp',
    config = function()
      require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/lua/snippets' })
    end,
  },

  -- nvim-cmp completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          -- Luasnip jump keybinds (C-l forward, C-h back)
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),
      })
    end,
  },

  -- GitHub Copilot (official vim plugin for enterprise auth)
  {
    'github/copilot.vim',
    event = 'InsertEnter',
    config = function()
      -- Tab to accept, don't conflict with cmp
      vim.g.copilot_no_tab_map = true
      vim.keymap.set('i', '<Tab>', 'copilot#Accept("\\<Tab>")', {
        expr = true,
        replace_keycodes = false,
        silent = true,
      })
      vim.keymap.set('i', '<S-Tab>', '<Plug>(copilot-next)', { silent = true })
    end,
  },

  -- Copilot Chat
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      'github/copilot.vim',
      'nvim-lua/plenary.nvim',
    },
    cmd = {
      'CopilotChat',
      'CopilotChatExplain',
      'CopilotChatReview',
      'CopilotChatTests',
    },
    keys = {
      { '<leader>cc', '<cmd>CopilotChat<CR>', desc = 'Copilot Chat' },
      { '<leader>ce', '<cmd>CopilotChatExplain<CR>', mode = { 'n', 'v' }, desc = 'Copilot explain' },
      { '<leader>cr', '<cmd>CopilotChatReview<CR>', mode = { 'n', 'v' }, desc = 'Copilot review' },
      { '<leader>ct', '<cmd>CopilotChatTests<CR>', mode = { 'n', 'v' }, desc = 'Copilot generate tests' },
    },
    opts = {},
  },
}

-- vim: ts=2 sts=2 sw=2 et
