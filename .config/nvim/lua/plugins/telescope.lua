return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = { prompt_position = 'top' },
          sorting_strategy = 'ascending',
          color_devicons = false,
          winblend = 0,
          mappings = {
            i = {
              ['<M-j>'] = require('telescope.actions').move_selection_next,
              ['<M-k>'] = require('telescope.actions').move_selection_previous,
              ['<Esc>'] = require('telescope.actions').close,
              ['<C-p>'] = require('telescope.actions').close,
            },
          },
          file_ignore_patterns = {
            '.git/',
            '.cache',
            '.docker/db',
            '.docker/sql',
            '.docker/mysql',
            '.docker/redis',
            'node%_modules/',
            'wp%-admin/',
            'wp%-includes/',
            'wp%-content/cache/',
            'wp%-content/languages/',
            'wp%-content/plugins/',
            'wp%-content/upgrade/',
            'wp%-content/uploads/',
            'wp%-content/wp-rocket-config/',

            '__pycache__/',
            '__pycache__/*',
            'env/',
            '%.min.js',
            'public/js/*',
            'public/css/*',

            '.github/',
            '.gradle/',
            '.idea/',
            '.vale/',
            '.vscode/',

            '%.cache',
            '%.class',
            '%.docx',
            '%.eot',
            '%.ico',
            '%.ipynb',
            '%.jar',
            '%.jpeg',
            '%.jpg',
            '%.lock',
            '%.met',
            '%.otf',
            '%.pdb',
            '%.pdf',
            '%.png',
            '%.sqlite3',
            '%.svg',
            '%.ttf',
            '%.webp',
            '.DS_Store',
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
            preview = false,
            theme = 'dropdown',
            previewer = false,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
    end,
  },
}
