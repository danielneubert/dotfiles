return {
  {
    'nvim-treesitter/nvim-treesitter',
    -- event = 'BufReadPost',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'c',
          'css',
          'scss',
          'typescript',
          'javascript',
          'html',
          'lua',
          'rust',
          'json',
          'yaml',
          'bash',
          'php',
          'toml',
        },

        sync_install = false,
        auto_install = false,

        indent = {
          enable = true,
        },

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'markdown' },
        },
      }
    end,
  },
}
