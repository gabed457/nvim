return {
  -- Bruno API testing (custom commands — no plugin exists)
  {
    'nvim-lua/plenary.nvim',
    name = 'bruno-commands',
    keys = {
      {
        '<leader>br',
        function()
          local file = vim.fn.expand('%:p')
          if not file:match('%.bru$') then
            vim.notify('Not a .bru file', vim.log.levels.WARN)
            return
          end
          vim.cmd('botright split | terminal bruno run ' .. vim.fn.shellescape(file))
        end,
        desc = 'Bruno: Run current .bru file',
      },
      {
        '<leader>be',
        function()
          -- Pick environment via telescope, then run collection
          local ok, pickers = pcall(require, 'telescope.pickers')
          if not ok then
            vim.cmd('botright split | terminal bruno run')
            return
          end
          local finders = require('telescope.finders')
          local conf = require('telescope.config').values
          local actions = require('telescope.actions')
          local action_state = require('telescope.actions.state')

          -- Find environment files in the workspace
          local handle = io.popen('find . -path "*/environments/*.bru" -type f 2>/dev/null')
          if not handle then return end
          local result = handle:read('*a')
          handle:close()

          local envs = {}
          for line in result:gmatch('[^\r\n]+') do
            -- Extract environment name from path
            local env_name = line:match('.*/environments/(.-)%.bru$')
            if env_name then
              table.insert(envs, { name = env_name, path = line })
            end
          end

          if #envs == 0 then
            vim.notify('No Bruno environments found', vim.log.levels.WARN)
            vim.cmd('botright split | terminal bruno run')
            return
          end

          local names = {}
          for _, e in ipairs(envs) do
            table.insert(names, e.name)
          end

          pickers.new({}, {
            prompt_title = 'Bruno Environment',
            finder = finders.new_table({ results = names }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  vim.cmd('botright split | terminal bruno run --env ' .. vim.fn.shellescape(selection[1]))
                end
              end)
              return true
            end,
          }):find()
        end,
        desc = 'Bruno: Run collection with env',
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
