return {
    {
        'romgrk/barbar.nvim',
        init = function() vim.g.barbar_auto_setup = false end,
        config = function()
            require('barbar').setup({
                animation = true,
                clickable = true,
                no_name_title = 'Leer',
                insert_at_end = true,
                icons = {
                    current = {
                        button = '',
                        separator_at_end = false,
                        modified = { button = '•' },
                        separator = { left = '', right = '' },
                    },
                    inactive = {
                        button = '',
                        separator_at_end = false,
                        modified = { button = '•' },
                        separator = { left = '', right = '' },
                    },
                    visible = {
                        button = '',
                        separator_at_end = false,
                        modified = { button = '•' },
                        separator = { left = '', right = '' },
                    },
                },
                maximum_length = 40,
                minimum_length = 10,
                maximum_padding = 1,
                minimum_padding = 1,
            })
        end,
    },
}
