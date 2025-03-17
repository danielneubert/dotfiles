return {
    {
        "saghen/blink.cmp",
        lazy = false,
        dependencies = "rafamadriz/friendly-snippets",
        version = 'v0.*',
        opts = {
            keymap = {
                preset = "enter",
                ['<Esc>'] = { 'fallback' },
                ['<Tab>'] = { 'select_and_accept', 'fallback' },
                ['<M-k>'] = { 'select_prev', 'fallback' },
                ['<M-j>'] = { 'select_next', 'fallback' },
                ['<C-Tab>'] = { 'snippet_forward', 'fallback' },
                ['<C-S-Tab>'] = { 'snippet_backward', 'fallback' },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },

            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
            },

            signature = { enabled = true },
        },
    },
}
