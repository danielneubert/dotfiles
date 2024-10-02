local wezterm = require 'wezterm'

function SetupFonts(config)
  config.freetype_load_target = 'Normal'
  config.font_size = 18
  config.line_height = 1.0
  config.font_rules = {
    {
      italic = false,
      font = wezterm.font {
        family = 'JetBrains Mono',
        harfbuzz_features = { 'ss19', 'cv14', 'cv18' },
        stretch = 'Normal',
        weight = 400,
        italic = false,
      },
    },
    {
      italic = true,
      font = wezterm.font {
        family = 'JetBrains Mono',
        harfbuzz_features = { 'ss19', 'cv14', 'cv18' },
        stretch = 'Normal',
        weight = 400,
        italic = true,
      },
    },
  }
end
