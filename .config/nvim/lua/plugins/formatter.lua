return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    opts = {
      formatters_by_ft = {
        go = { 'gofmt', 'goimports' },
        javascript = { { 'prettierd', 'prettier' } },
        json = { 'jq' },
        lua = { 'stylua' },
        php = { 'php_cs_fixer' },
        ['*'] = { 'typos', 'trim_newlines', 'trim_whitespace' },
      },
      format_on_save = function() end,
    },
  },
}
