return {
  {
    'projekt0n/github-nvim-theme',
    priority = 1000,
    config = function()
      function ColorGitHub()
        require('github-theme').setup {}
        vim.cmd 'colorscheme github_light_default'
      end

      vim.api.nvim_create_user_command('Sun', function()
        ColorGitHub()
      end, {})
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      function ColorNightFox()
        require('nightfox').setup {}
        vim.cmd 'colorscheme duskfox'
      end

      vim.api.nvim_create_user_command('Dark', function()
        ColorNightFox()
      end, {})

      ColorNightFox()
    end,
  },
  {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      function ColorSolarizedLight()
        vim.o.background = 'light'
        vim.cmd.colorscheme 'solarized'
      end

      vim.api.nvim_create_user_command('Day', function()
        ColorSolarizedLight()
      end, {})
    end,
  },
}
