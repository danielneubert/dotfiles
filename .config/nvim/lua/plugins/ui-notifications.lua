return {
    {
        "folke/noice.nvim",
        config = function()
            require('noice').setup {
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
                                { find = 'only match' },
                                { find = 'match %d of' },
                                { find = 'Back at original' },
                                { find = 'lines <ed %d time' },
                                { find = 'lines >ed %d time' },
                                { find = 'lines moved' },
                                { find = 'lines indented' },
                                { find = 'NvimTree' },
                                { find = 'No code actions available' },
                            },
                        },
                        opts = { skip = true },
                    },
                },
            }
        end,
    },
}
