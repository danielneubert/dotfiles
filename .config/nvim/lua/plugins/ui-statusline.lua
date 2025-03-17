return {
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
                        local filename      = vim.fn.expand('%:p')
                        local home          = vim.fn.expand(vim.fn.getcwd())
                        local diff          = MiniStatusline.section_diff { trunc_width = 75 }
                        local git           = statusline.section_git { trunc_width = 75 }
                        local mode, mode_hl = statusline.section_mode { trunc_width = 120 }

                        filename            = filename:gsub('^' .. home .. '/', '')

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
        end,
    },
}
