function setColors(name, config, schemeName)
  config = config or {}
  schemeName = schemeName or name
  require(name).setup(config)
  vim.cmd.colorscheme(schemeName)
end

return {
  {
    'projekt0n/github-nvim-theme',
    priority = 1000,
    config = function()
      function ColorGitHub()
        setColors('github-theme', {}, 'github_light_default')
      end

      vim.api.nvim_create_user_command('Day', function()
        ColorGitHub()
      end, {})
    end,
  },
  {
    'oxfist/night-owl.nvim',
    priority = 1000,
    config = function()
      function ColorOwl()
        setColors 'night-owl'
      end

      vim.api.nvim_create_user_command('Dark', function()
        ColorOwl()
      end, {})

      ColorOwl()
    end,
  },
}
