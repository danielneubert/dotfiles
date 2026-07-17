return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local languages = {
        'c',
        'cpp',
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
      }

      require('nvim-treesitter').install(languages)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'c',
          'cpp',
          'css',
          'scss',
          'typescript',
          'javascript',
          'html',
          'lua',
          'rust',
          'json',
          'jsonc',
          'yaml',
          'sh',
          'php',
          'toml',
        },
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
