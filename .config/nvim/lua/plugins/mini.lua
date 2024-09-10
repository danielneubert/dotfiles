return {
    {
        'nvim-tree/nvim-web-devicons',
        priority = 1000,
    },
    {
        'echasnovski/mini.nvim',
        priority = 1000,
        config = function()
            require('mini.ai').setup { n_lines = 500 }

            local statusline = require 'mini.statusline'
            statusline.setup {
                show_icon = false,

                content = {
                    active = function()
                        local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
                        local git           = statusline.section_git { trunc_width = 75 }
                        local diff          = MiniStatusline.section_diff { trunc_width = 75 }
                        local filename      = statusline.section_filename { trunc_width = 140 }
                        local lsp           = MiniStatusline.section_lsp { trunc_width = 75 }

                        if mode_hl == 'MiniStatuslineModeNormal' then
                            mode_hl = 'MiniStatuslineFilename'
                        end

                        return statusline.combine_groups {
                            { hl = mode_hl,                  strings = { mode } },
                            { hl = 'MiniStatuslineFilename', strings = { git, diff } },
                            '%<',
                            '%=',
                            { hl = 'MiniStatuslineDevinfo', strings = { filename } },
                        }
                    end,
                },
            }

            local tabline = require 'mini.tabline'
            tabline.setup {
                show_icons = true,
            }
        end,
    },
}
