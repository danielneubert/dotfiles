return {
    {
        "zbirenbaum/copilot.lua",
        priority = 1000,
        config = function()
            -- Init copilot by typing ":Co"
            vim.api.nvim_create_user_command('Co', function()
                require("copilot").setup({
                    suggestion = {
                        auto_trigger = true,
                        keymap = {
                            accept = '<M-Tab>', -- Alt + Tab (macOS)
                        },
                    },
                    filetypes = {
                        ['.'] = false,
                        ['.env'] = false,
                        cvs = false,
                        gitcommit = false,
                        gitrebase = false,
                        help = false,
                        hgcommit = false,
                        markdown = false,
                        svn = false,
                        yaml = false,
                    },
                })
            end, {})
        end,
    },
}
