local wezterm = require 'wezterm'

function SetupFonts(config)
  config.freetype_load_target = 'Normal'
  config.font_size = 16
  config.line_height = 1.1 -- .375
  config.font_rules = {

    -- Normal Text
    {
      italic = false,
      font = wezterm.font {
        family = 'JetBrains Mono',
        stretch = 'Normal',
        harfbuzz_features = { 'ss19' },
        weight = 500,
        italic = false,
      },
    },

    -- Italic Text
    {
      italic = true,
      font = wezterm.font {
        family = 'MonoLisa',
        stretch = 'Normal',
        harfbuzz_features = { 'zero', 'ss02', 'ss03', 'ss07', 'ss10', 'ss11', 'ss13', 'ss14', 'ss17' },
        weight = 500,
        italic = true,
      },
    },
  }
end
