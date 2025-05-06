return {
    'stevearc/oil.nvim',
    opts = {
        columns = {
            "icon",
        },
        skip_confirm_for_simple_edits = true,
        view_options = {
            show_hidden = true,
        },
        keymaps = {
            ["g?"] = "actions.show_help",
            ["sv"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
            ["sc"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
            ["<Esc>"] = "actions.close",
            ["r"] = "actions.refresh",
        },
    },
    lazy = false,
}
