return {
  {
    'rose-pine/neovim',
    priority = 1000,
    config = function()
      function ColorRose()
        require('rose-pine').setup {
          variant = 'main',
          extend_background_behind_borders = true,
          enable = {
            terminal = true,
            legacy_highlights = true,
            migrations = true,
          },
          styles = {
            bold = true,
            italic = true,
            transparency = true,
          },
        }

        vim.cmd.colorscheme 'rose-pine'
      end

      function ColorRoseDawn()
        require('rose-pine').setup {
          variant = 'dawn',
          extend_background_behind_borders = true,
          enable = {
            terminal = true,
            legacy_highlights = true,
            migrations = true,
          },
          styles = {
            bold = true,
            italic = true,
            transparency = true,
          },
        }

        vim.cmd.colorscheme 'rose-pine'
      end

      vim.api.nvim_create_user_command('Dark', function()
        ColorRose()
      end, {})

      vim.api.nvim_create_user_command('Dawn', function()
        ColorRoseDawn()
      end, {})

      ColorRose()
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    priority = 1000,
    config = function()
      function ColorGitHub()
        require('github-theme').setup {}
        vim.cmd 'colorscheme github_light_default'
      end

      vim.api.nvim_create_user_command('Day', function()
        ColorGitHub()
      end, {})
    end,
  },
  {
    'cormacrelf/dark-notify',
    priority = 1000,
    config = function()
      local dark_notify = require 'dark_notify'

      -- Configure
      dark_notify.run {
        onchange = function(mode)
          if mode == 'dark' then
            ColorRose()
          else
            ColorRoseDawn()
          end
        end,
      }
    end,
  },
}
