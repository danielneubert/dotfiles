function SetColors(name, config, schemeName)
  config = config or {}
  schemeName = schemeName or name
  require(name).setup(config)
  vim.cmd.background = 'dark'
  vim.cmd.colorscheme(schemeName)
end

return {
  {
    'projekt0n/github-nvim-theme',
    priority = 1000,
    config = function()
      function ColorGitHub()
        SetColors('github-theme', {}, 'github_light_default')
      end

      vim.api.nvim_create_user_command('Day', function()
        ColorGitHub()
      end, {})
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      function ColorDark()
        SetColors('tokyonight', {
          style = 'moon',
          light_style = 'moon',
          transparent = true,
          styles = {
            comments = { italic = true },
            functions = { italic = true },
            keywords = { italic = false },
            variables = { italic = true },
          },
        }, 'tokyonight-moon')
      end

      vim.api.nvim_create_user_command('Dark', function()
        ColorDark()
      end, {})

      ColorDark()
    end,
  },
}
