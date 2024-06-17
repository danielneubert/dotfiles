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
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      function ColorKanagawa()
        require('kanagawa').setup {
          commentStyle = { italic = true },
          functionStyle = { italic = true },
          keywordStyle = { italic = true },
          typeStyle = { italic = true },
        }
        vim.cmd.colorscheme 'kanagawa-wave'
      end

      function ColorKanagawaDay()
        require('kanagawa').setup {
          commentStyle = { italic = true },
          functionStyle = { italic = true },
          keywordStyle = { italic = true },
          typeStyle = { italic = true },
        }
        vim.cmd.colorscheme 'kanagawa-lotus'
      end

      vim.api.nvim_create_user_command('Dark', function()
        ColorKanagawa()
      end, {})

      ColorKanagawa()

      vim.api.nvim_create_user_command('Day', function()
        ColorKanagawaDay()
      end, {})
    end,
  },
}
