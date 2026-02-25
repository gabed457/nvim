return {
  -- Kubernetes helpers via kubectl
  -- Lightweight keybinds for quick lookups — heavy k8s stays in terminal/k9s
  {
    'nvim-lua/plenary.nvim',
    keys = {
      {
        '<leader>kp',
        function()
          vim.cmd('botright split | terminal kubectl get pods')
        end,
        desc = 'K8s: Get pods',
      },
      {
        '<leader>kl',
        function()
          -- Get pod name from word under cursor or prompt
          local pod = vim.fn.expand('<cword>')
          if pod == '' then
            pod = vim.fn.input('Pod name: ')
          end
          if pod ~= '' then
            vim.cmd('botright split | terminal kubectl logs -f ' .. vim.fn.shellescape(pod))
          end
        end,
        desc = 'K8s: Stream logs',
      },
      {
        '<leader>kd',
        function()
          local resource = vim.fn.input('Resource (e.g. pod/name): ')
          if resource ~= '' then
            vim.cmd('botright split | terminal kubectl describe ' .. resource)
          end
        end,
        desc = 'K8s: Describe resource',
      },
      {
        '<leader>kc',
        function()
          -- Switch context via telescope
          local ok, pickers = pcall(require, 'telescope.pickers')
          if not ok then
            vim.cmd('botright split | terminal kubectl config get-contexts')
            return
          end
          local finders = require('telescope.finders')
          local conf = require('telescope.config').values
          local actions = require('telescope.actions')
          local action_state = require('telescope.actions.state')

          local handle = io.popen('kubectl config get-contexts -o name 2>/dev/null')
          if not handle then return end
          local result = handle:read('*a')
          handle:close()

          local contexts = {}
          for line in result:gmatch('[^\r\n]+') do
            table.insert(contexts, line)
          end

          pickers.new({}, {
            prompt_title = 'K8s Contexts',
            finder = finders.new_table({ results = contexts }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  vim.fn.system('kubectl config use-context ' .. vim.fn.shellescape(selection[1]))
                  vim.notify('Switched to context: ' .. selection[1])
                end
              end)
              return true
            end,
          }):find()
        end,
        desc = 'K8s: Switch context',
      },
      {
        '<leader>kn',
        function()
          -- Switch namespace via telescope
          local ok, pickers = pcall(require, 'telescope.pickers')
          if not ok then
            vim.cmd('botright split | terminal kubectl get namespaces')
            return
          end
          local finders = require('telescope.finders')
          local conf = require('telescope.config').values
          local actions = require('telescope.actions')
          local action_state = require('telescope.actions.state')

          local handle = io.popen('kubectl get namespaces -o jsonpath="{.items[*].metadata.name}" 2>/dev/null')
          if not handle then return end
          local result = handle:read('*a')
          handle:close()

          local namespaces = {}
          for ns in result:gmatch('%S+') do
            table.insert(namespaces, ns)
          end

          pickers.new({}, {
            prompt_title = 'K8s Namespaces',
            finder = finders.new_table({ results = namespaces }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  vim.fn.system('kubectl config set-context --current --namespace=' .. vim.fn.shellescape(selection[1]))
                  vim.notify('Switched to namespace: ' .. selection[1])
                end
              end)
              return true
            end,
          }):find()
        end,
        desc = 'K8s: Switch namespace',
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
