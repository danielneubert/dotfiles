return {
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = "markdown",
        lazy = false,
        opts = {
            ui = { enable = false },

            workspaces = {
                {
                    name = "main",
                    path = vim.fn.getenv("OBSIDIAN_VAULT"),
                },
            },

            notes_subdir = "00 – notes",
            new_notes_location = "notes_subdir",
            daily_notes = {
                folder = "01 — logs",
                date_format = "%Y-%m-%d",
            },
            templates = {
                folder = "04 — templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
            },

            completion = {
                min_chars = 1,
            },

            note_id_func = function(title)
                local task = false

                if title:sub(1, 1) == "!" then
                    task = true
                    title = title:sub(2)
                end

                local path = vim.fn.strftime("%Y")
                path = path .. "/" .. vim.fn.strftime("%m")

                if task then
                    path = path .. "/Tasks"
                end

                local month = tonumber(vim.fn.strftime("%m"))
                local monthHex = string.format("%X", month)

                path = path .. "/" .. vim.fn.strftime("%y") .. monthHex
                path = path .. " " .. title

                return path
            end,

            disable_frontmatter = true,

            mappings = {
                ["<leader><space>"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
            },
        },
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        opts = {
            heading = {
                position = 'inline',
                icons = { '󰉫 ', '󰉬 ', '󰉭 ', '󰉮 ', '󰉯 ', '󰉰 ' },
                left_pad = 1,
                width = 'full',
                backgrounds = {
                    'Comment',
                    'Comment',
                    'Comment',
                    'Comment',
                    'Comment',
                    'Comment',
                },
            },
            code = {
                left_pad = 1,
                style = "normal",
                language_pad = 1,
                highlight_language = 'Comment',
            },
            bullet = {
                icons = { '•', '◦', '▪', '▫' },
                left_pad = 2,
                right_pad = 1,
            },
            dash = {
                icon = '┅',
                width = '80',
            },
            quote = {
                icon = '┋',
                repeat_linebreak = true,
            },
            link = {
                image = '󰥶 ',
                email = '󰀓 ',
                hyperlink = '󰌹  ',
                highlight = 'RenderMarkdownLink',
                wiki = { icon = '󱗖  ', highlight = 'RenderMarkdownWikiLink' },
            },
            callout = {
                note = { raw = '[!NOTE]', rendered = '󰋽  Note', highlight = 'RenderMarkdownInfo' },
                tip = { raw = '[!TIP]', rendered = '󰌶  Tip', highlight = 'RenderMarkdownSuccess' },
                important = { raw = '[!IMPORTANT]', rendered = '󰅾  Important', highlight = 'RenderMarkdownHint' },
                warning = { raw = '[!WARNING]', rendered = '󰀪  Warning', highlight = 'RenderMarkdownWarn' },
                info = { raw = '[!INFO]', rendered = '󰋽  Info', highlight = 'RenderMarkdownInfo' },
                success = { raw = '[!SUCCESS]', rendered = '󰄬  Success', highlight = 'RenderMarkdownSuccess' },
                done = { raw = '[!DONE]', rendered = '󰄬  Done', highlight = 'RenderMarkdownSuccess' },
                help = { raw = '[!HELP]', rendered = '󰘥  Help', highlight = 'RenderMarkdownWarn' },
                faq = { raw = '[!FAQ]', rendered = '󰘥  Faq', highlight = 'RenderMarkdownWarn' },
                attention = { raw = '[!ATTENTION]', rendered = '󰀪  Attention', highlight = 'RenderMarkdownWarn' },
                fail = { raw = '[!FAIL]', rendered = '󰅖  Fail', highlight = 'RenderMarkdownError' },
                danger = { raw = '[!DANGER]', rendered = '󱐌  Danger', highlight = 'RenderMarkdownError' },
                error = { raw = '[!ERROR]', rendered = '󱐌  Error', highlight = 'RenderMarkdownError' },
                bug = { raw = '[!BUG]', rendered = '󰨰  Bug', highlight = 'RenderMarkdownError' },
            },
        },
    }
}
