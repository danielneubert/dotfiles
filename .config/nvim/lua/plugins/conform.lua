return {
    {
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        opts = {
            formatters_by_ft = {
            },
        },
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    go = { 'gofmt', 'goimports' },
                    blade = { "blade-formatter" },
                    javascript = { 'prettier' },
                    vue = { 'prettier' },
                    json = { 'jq' },
                    lua = { 'stylua' },
                    php = { 'php_cs_fixer' },
                    ['*'] = { 'trim_newlines', 'trim_whitespace' },
                },
                format_on_save = {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                },
                notify_on_error = true,
                formatters = {
                    php = {
                        env = {
                            PHP_CS_FIXER_IGNORE_ENV = 1,
                        },
                        command = "php-cs-fixer",
                        args = {
                            "fix",
                            "$FILENAME",
                            -- "--config=/your/path/to/config/file/[filename].php",
                        },
                        stdin = false,
                    }
                }
            })
        end,
    },
}
