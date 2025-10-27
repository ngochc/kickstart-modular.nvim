return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      -- Format the whole buffer
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = 'n',
        desc = '[C]ode [F]ormat buffer',
      },
      -- Format a visual selection
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback', range = true }
        end,
        mode = 'x',
        desc = '[C]ode [F]ormat selection',
      },
      -- Toggle format on save
      {
        '<leader>tf',
        function()
          vim.g.autoformat_on_save = not vim.g.autoformat_on_save
          local msg = 'Format on save: ' .. (vim.g.autoformat_on_save and 'ON' or 'OFF')
          if vim.notify then vim.notify(msg) else print(msg) end
        end,
        mode = 'n',
        desc = '[T]oggle [F]ormat on save',
      },
    },
    opts = {
      notify_on_error = false,
      -- Global toggle for format on save
      format_on_save = function(bufnr)
        if vim.g.autoformat_on_save == nil then vim.g.autoformat_on_save = true end
        if not vim.g.autoformat_on_save then return nil end
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Python
        python = { 'ruff_organize_imports', 'ruff_format', 'black' },
        -- JavaScript / TypeScript / JSON / Markdown
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        jsonc = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
        -- Go
        go = { 'goimports', 'gofmt' },
        -- Java
        java = { 'google-java-format' },
      },
      -- Optional: per-formatter settings (only when installed)
      formatters = {
        ['google-java-format'] = {
          prepend_args = { '--aosp' },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
