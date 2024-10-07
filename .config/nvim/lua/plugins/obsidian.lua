return {
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        lazy = false,
        enabled = function()
            return vim.fn.getcwd() == vim.fn.getenv("OBSIDIAN_VAULT")
        end,
        opts = {
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
                return title
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
}
