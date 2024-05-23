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
            local git = statusline.section_git { trunc_width = 75 }
            local filename = statusline.section_filename { trunc_width = 140 }
            local search = statusline.section_searchcount { trunc_width = 75 }
            local location = string.format('%d:%d', vim.fn.line '.', vim.fn.col '.')

            return statusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { filename } },
              '%<', -- Mark general truncate point
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFilename', strings = { git } },
              { hl = 'MiniStatuslineDevinfo', strings = { search } },
              { hl = mode_hl, strings = { location } },
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
