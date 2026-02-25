return {
  -- TypeScript LSP (faster than ts_ls via lspconfig)
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = 'all',
          includeCompletionsForModuleExports = true,
          quotePreference = 'single',
        },
        tsserver_format_options = {
          allowIncompleteCompletions = false,
          allowRenameOfImportPath = false,
        },
      },
    },
  },

  -- SchemaStore for JSON/YAML schemas
  { 'b0o/SchemaStore.nvim', lazy = true },

  -- Mason + LSPConfig
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'b0o/SchemaStore.nvim',
    },
    config = function()
      -- LSP attach keybinds
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', vim.lsp.buf.definition, 'Go to definition')
          map('gr', vim.lsp.buf.references, 'References')
          map('gi', vim.lsp.buf.implementation, 'Implementation')
          map('K', vim.lsp.buf.hover, 'Hover documentation')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'v' })
          map('<leader>rn', vim.lsp.buf.rename, 'Rename')
          map('gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('<leader>D', vim.lsp.buf.type_definition, 'Type definition')

          -- Document highlight
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local hl_group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = hl_group,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(ev)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = ev.buf })
              end,
            })
          end

          -- Inlay hints toggle
          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, 'Toggle inlay hints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Merge with cmp capabilities if available
      local ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
      if ok then
        capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
      end

      -- Server configs
      local servers = {
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = { enable = false, url = '' },
              schemas = require('schemastore').yaml.schemas(),
              validate = true,
              completion = true,
            },
          },
        },
        dockerls = {},
        helm_ls = {},
        graphql = {},
        bashls = {},
        sqlls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      }

      -- Ensure tools are installed
      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, {
        'prettierd',
        'prettier',
        'eslint_d',
        'stylua',
        'sql-formatter',
      })

      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            -- Skip tsserver/ts_ls — handled by typescript-tools.nvim
            if server_name == 'ts_ls' or server_name == 'tsserver' then
              return
            end
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
  },

  -- Human-readable TypeScript errors
  {
    'dmmulroy/ts-error-translator.nvim',
    ft = { 'typescript', 'typescriptreact' },
    opts = {},
  },
}

-- vim: ts=2 sts=2 sw=2 et
