return {
    -- notification system
    {
        "rcarriga/nvim-notify",
    },

    -- notifications & floating command bar
    {
        "folke/noice.nvim",
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
                                { find = 'only match' },
                                { find = 'match %d of' },
                                { find = 'Back at original' },
                                { find = 'lines <ed %d time' },
                                { find = 'lines >ed %d time' },
                                { find = 'lines moved' },
                                { find = 'lines indented' },
                            },
                        },
                        opts = { skip = true },
                    },
                },
            }
        end,
    },
}