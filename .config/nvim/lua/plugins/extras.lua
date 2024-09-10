return {
    {
        'tpope/vim-sleuth',
        priority = 1000,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = "▏" },
            whitespace = { highlight = { "Whitespace", "NonText" } },
            scope = { enabled = false },
        },
    }
}
