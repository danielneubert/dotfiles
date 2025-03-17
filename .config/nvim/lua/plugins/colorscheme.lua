local function setColors(theme, config, scheme)
    if theme ~= nil then
        require(theme).setup(config)

        if config ~= nil then
            require(theme).setup(config)
        else
            require(theme).setup({})
        end
    end

    vim.cmd.background = "dark"
    vim.cmd.colorscheme(scheme or theme)

    local updateBarbar = function(defines)
        local g = function(hl, name)
            local color = vim.api.nvim_get_hl(0, { name = name })[hl]
            if color then return ("#%06x"):format(color) end
        end
        for _, group in pairs(defines) do
            for _, buffer in ipairs(group.buffers) do
                vim.api.nvim_set_hl(0, "Buffer" .. buffer, {
                    fg = g("fg", group.hl.fg), bg = g("bg", group.hl.bg)
                })
            end
        end
    end

    updateBarbar({ {
        hl = { fg = "Normal" },
        buffers = { "Tabpagse", "TabpagesSep", "TabpageFill" },
    }, {
        hl = { fg = "Normal", bg = "CursorLine" },
        buffers = { "Current", "CurrentMod", "CurrentSign" },
    }, {
        hl = { fg = "Comment", bg = "CursorLine" },
        buffers = { "VisibleMod", "InactiveMod" },
    }, {
        hl = { fg = "Comment" },
        buffers = { "Visible", "Inactive", "VisibleSign", "InactiveSign" },
    } })
end

return {
    {
        "projekt0n/github-nvim-theme",
        priority = 1000,
        config = function()
            vim.api.nvim_create_user_command("Day", function()
                setColors("github-theme", {
                    options = {
                        styles = {
                            comments = "italic",
                        },
                    },
                }, "github_light_default")
            end, {})
        end,
    },
    {
        "oxfist/night-owl.nvim",
        priority = 1000,
        config = function()
            vim.api.nvim_create_user_command("Owl", function()
                setColors("night-owl")
            end, {})

            vim.cmd("Owl")
        end,
    },
}
