return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        go = { 'gofmt', 'goimports' },
        javascript = { 'prettier' },
        vue = { 'prettier' },
        json = { 'jq' },
        lua = { 'stylua' },
        php = { 'php_cs_fixer' },
        ['*'] = { 'trim_newlines', 'trim_whitespace' },
      },
      format_on_save = {
        async = false,
        timeout_ms = 1000,
        lsp_fallback = true,
      },
      notify_on_error = true,
      formatters = {
        php = {
          -- env = {
          --   PHP_CS_FIXER_IGNORE_ENV = 1,
          -- },
          command = 'php-cs-fixer',
          args = {
            'fix',
            '$FILENAME',
          },
          stdin = false,
        },
      },
    },
  },
}
