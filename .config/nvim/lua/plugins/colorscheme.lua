local function setColors(name, config, schemeName)
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
                setColors('github-theme', {}, 'github_light_default')
            end

            vim.api.nvim_create_user_command('Day', function()
                ColorGitHub()
            end, {})
        end,
    },
    {
        'catppuccin/nvim',
        priority = 1000,
        config = function()
            function ColorCat()
                setColors('catppuccin', {
                    flavour = 'mocha',
                    transparent_background = true, -- disables setting the background color.
                    show_end_of_buffer = true,     -- shows the '~' characters after the end of buffers
                    term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
                    styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
                        comments = { 'italic' },   -- Change the style of comments
                        strings = { 'italic' },
                    },
                })
            end

            vim.api.nvim_create_user_command('Cat', function()
                ColorCat()
            end, {})
        end,
    },
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        config = function()
            function ColorDark()
                setColors('tokyonight', {
                    style = "storm",
                    light_style = "storm",
                    transparent = true,
                    styles = {
                        comments = { italic = true },
                        keywords = { italic = true },
                        functions = {},
                        variables = {},
                        sidebars = "dark",
                        floats = "dark",
                    },
                })
            end

            vim.api.nvim_create_user_command('Dark', function()
                ColorDark()
            end, {})

            ColorDark()
        end,
    },
}
