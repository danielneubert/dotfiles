local function setColors(name, config, schemeName)
    config = config or {}
    schemeName = schemeName or name

    vim.cmd.background = 'dark'
    require(name).setup(config)
    vim.cmd.colorscheme(schemeName)

    local get_color = function(name, variant)
        local colors = vim.api.nvim_get_hl(0, { name = name })
        return (colors[variant] ~= nil) and ('#%06x'):format(colors[variant]) or '#ff00ff'
    end

    local set_color = function(name, fg, bg)
        vim.api.nvim_set_hl(0, name, { fg = fg, bg = bg or fg })
    end

    local color_bg = get_color('Normal', 'bg')
    local color_bg_dark = "#000000"
    local color_fg = get_color('Normal', 'fg')
    local color_fg_dark = get_color('Comment', 'fg')

    set_color("BufferTabpageFill", color_bg_dark)
    set_color("BufferTabpages", color_bg_dark)
    set_color("BufferTabpagesSep", color_bg_dark)
    set_color("BufferCurrent", color_fg, color_bg)
    set_color("BufferCurrentMod", color_fg, color_bg)
    set_color("BufferCurrentSign", color_fg_dark, color_bg)
    set_color("BufferInactive", color_fg_dark, color_bg_dark)
    set_color("BufferInactiveMod", color_fg, color_bg_dark)
    set_color("BufferInactiveSign", color_fg_dark, color_bg_dark)
    set_color("BufferVisible", color_fg_dark, color_bg_dark)
    set_color("BufferVisibleMod", color_fg, color_bg_dark)
    set_color("BufferVisibleSign", color_fg_dark, color_bg_dark)
end

return {
    -- day colorscheme
    {
        'projekt0n/github-nvim-theme',
        priority = 1000,
        config = function()
            vim.api.nvim_create_user_command('Day', function()
                setColors('github-theme', {
                    options = {
                        styles = {
                            comments = 'italic',
                        },
                    },
                }, 'github_light_default')
            end, {})
        end,
    },

    -- dark colorscheme
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        config = function()
            vim.api.nvim_create_user_command('Dark', function()
                setColors('tokyonight', {
                    style = "moon",
                    styles = {
                        comments = { italic = true },
                    },
                })
            end, {})

            vim.cmd('Dark')
        end,
    },
}
