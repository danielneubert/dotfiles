return {
    {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {
                background_colour = '#000000',
                enabled = false,
            }
        end,
    },

    {
        'folke/noice.nvim',
        config = function()
            require('noice').setup {
                -- add any options here
                routes = {
                    {
                        filter = {
                            event = 'msg_show',
                            any = {
                                { find = '%d+L, %d+B' },
                                { find = '; after #%d+' },
                                { find = '; before #%d+' },
                                { find = '%d fewer lines' },
                                { find = '%d more lines' },
                            },
                        },
                        opts = { skip = true },
                    },
                },
            }
        end,
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
    },
}
