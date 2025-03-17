return {
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        config = function()
            require("zen-mode").setup({
                window = {
                    width = 100,
                    options = {
                        cursorcolumn = false,
                        number = false,
                        relativenumber = false,
                        signcolumn = "no",
                    },
                },
            })
        end,
    },
}
