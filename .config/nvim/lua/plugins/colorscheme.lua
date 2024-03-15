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

      vim.api.nvim_create_user_command('Rose', function()
        ColorRose()
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
}
