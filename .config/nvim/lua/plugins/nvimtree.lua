return {
  {
    'nvim-tree/nvim-tree.lua',
    priority = 1000,
    opts = {
      view = {
        cursorline = true,
        number = false,
        relativenumber = false,
        signcolumn = 'no',

        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * 0.5
            local window_h = screen_h * 0.9
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * 0.5)
        end,
      },
      renderer = {
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = 'none', -- none
        highlight_modified = 'none',
        root_folder_label = false,
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = '└',
            edge = '│',
            item = '│',
            bottom = '─',
            none = ' ',
          },
        },
        icons = {
          web_devicons = {
            file = {
              enable = true,
              color = false,
            },
            folder = {
              enable = false,
              color = false,
            },
          },
          git_placement = 'after',
          modified_placement = 'after',
          padding = ' ',
          symlink_arrow = '->',
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = {
            default = '',
            symlink = ' ⇒ ',
            bookmark = '',
            modified = '*',
            folder = {
              arrow_closed = '',
              arrow_open = '',
              default = '',
              open = '',
              empty = '',
              empty_open = '',
              symlink = '',
              symlink_open = '',
            },
            git = {
              -- Matches Tower client
              unstaged = 'M',
              staged = 'A',
              unmerged = '⚠',
              renamed = 'R',
              untracked = '?',
              deleted = '-',
              ignored = '‼',
            },
          },
        },
        special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
        symlink_destination = true,
      },
      diagnostics = {
        enable = false,
      },
      filters = {
        custom = {
          '^\\.git',
          'node_modules',
          '^\\.DS_Store',
        },
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 500,
        ignore_dirs = {},
      },
      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 500,
      },
      modified = {
        enable = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      trash = {
        cmd = 'trash', -- enable trash instead of rm
      },
      on_attach = function(treeBuffer)
        local api = require 'nvim-tree.api'

        local map = function(key, call, desc)
          vim.keymap.set('n', key, call, { buffer = treeBuffer, desc = desc })
        end

        map('<C-e>', api.tree.close, 'Close NvimTree')
        map('<Esc>', api.tree.close, 'Close NvimTree')
        map('<cr>', api.node.open.edit, 'Open')
        map('<2-LeftMouse>', api.node.open.edit, 'Open')
        map('sv', api.node.open.vertical, 'Open in Vertical Split')
        map('sc', api.node.open.horizontal, 'Open in Horizontal Split')
        map('d', api.fs.trash, 'Trash')
        map('a', api.fs.create, 'Create')
        map('o', api.fs.create, 'Create')
        map('y', api.fs.copy.node, 'Copy')
        map('p', api.fs.paste, 'Paste')
        map('r', api.tree.reload, 'Reload')
        map('rn', api.fs.rename, 'Rename')
        map('x', api.fs.cut, 'Cut')
        map('?', api.tree.toggle_help, 'Show Help')
        map('gh', api.tree.toggle_custom_filter, 'Toggle Hidden')
      end,
    },
  },
}
