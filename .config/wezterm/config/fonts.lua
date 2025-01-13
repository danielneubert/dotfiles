local wezterm = require 'wezterm'

function SetupFonts(config)
    config.cell_width = 1.0

    -- JetBrains
    config.font_size = 19
    config.line_height = 1.0
    config.freetype_load_target = 'Light'
    config.font = wezterm.font("JetBrains Mono")

    -- -- Iosevka
    -- config.font_size = 22
    -- config.line_height = 0.925
    -- config.freetype_load_target = 'HorizontalLcd'
    -- config.font = wezterm.font("IosevkaTerm Nerd Font Mono")

    -- Iosevka
    config.font_size = 20
    config.line_height = 1.05
    config.freetype_load_target = 'HorizontalLcd'
    config.font = wezterm.font("ComicCodeLigatures")
end
