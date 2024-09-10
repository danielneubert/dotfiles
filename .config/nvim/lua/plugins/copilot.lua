return {
    {
        'zbirenbaum/copilot.lua',
        priority = 1000,
        opts = {
            suggestion = {
                auto_trigger = true,
                debounce = 200,
                enabled = true,
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
        },
    },
}
