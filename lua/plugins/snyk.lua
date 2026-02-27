return {
  -- Snyk security integration
  -- Uses nvim-lint for async SAST diagnostics + terminal commands for full scans
  {
    'mfussenegger/nvim-lint',
    name = 'snyk-lint',
    keys = {
      {
        '<leader>Ss',
        function()
          vim.cmd('botright split | terminal snyk test')
        end,
        desc = 'Snyk: Dependency scan',
      },
      {
        '<leader>Sc',
        function()
          vim.cmd('botright split | terminal snyk code test')
        end,
        desc = 'Snyk: SAST scan',
      },
    },
    config = function()
      local lint = require('lint')

      -- Custom Snyk SAST linter
      lint.linters.snyk_code = {
        cmd = 'snyk',
        args = { 'code', 'test', '--json' },
        stdin = false,
        append_fname = false,
        stream = 'stdout',
        ignore_exitcode = true,
        parser = function(output, bufnr)
          local diagnostics = {}
          local ok, decoded = pcall(vim.json.decode, output)
          if not ok or not decoded or not decoded.runs then
            return diagnostics
          end

          local bufname = vim.api.nvim_buf_get_name(bufnr)
          for _, run in ipairs(decoded.runs or {}) do
            for _, result in ipairs(run.results or {}) do
              for _, location in ipairs(result.locations or {}) do
                local phys = location.physicalLocation
                if phys and phys.artifactLocation then
                  local uri = phys.artifactLocation.uri or ''
                  -- Only include diagnostics for current file
                  if bufname:match(vim.pesc(uri) .. '$') then
                    local region = phys.region or {}
                    table.insert(diagnostics, {
                      lnum = (region.startLine or 1) - 1,
                      col = (region.startColumn or 1) - 1,
                      end_lnum = (region.endLine or region.startLine or 1) - 1,
                      end_col = (region.endColumn or 1) - 1,
                      severity = vim.diagnostic.severity.WARN,
                      source = 'snyk',
                      message = result.message and result.message.text or 'Snyk issue detected',
                    })
                  end
                end
              end
            end
          end
          return diagnostics
        end,
      }

      -- NOTE: Snyk SAST is NOT auto-triggered on save due to its slow speed.
      -- Run it manually via <leader>Sc or explicitly by adding it:
      -- lint.linters_by_ft.typescript = vim.list_extend(lint.linters_by_ft.typescript or {}, { 'snyk_code' })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
