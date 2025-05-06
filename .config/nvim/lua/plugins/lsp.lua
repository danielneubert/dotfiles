return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
        map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local function client_supports_method(client, method, bufnr)
          return client:supports_method(method, bufnr)
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })

    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      },
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    local original_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require('blink.cmp').get_lsp_capabilities(original_capabilities)
    local servers = {
      bashls = {},
      marksman = {},
      phpactor = {
        root_dir = function(fname)
          local cwd = vim.fn.getcwd()
          local user_home = vim.fn.expand '~'
          local file_path = vim.fn.fnamemodify(fname, ':p')
          local file_dir = vim.fn.fnamemodify(fname, ':p:h')

          vim.notify('[PhpactorRootDebug] File: ' .. file_path)
          vim.notify('[PhpactorRootDebug] CWD: ' .. cwd)

          -- If the cwd is just the home directory, fallback to the current file's directory
          if cwd == user_home then
            vim.notify('[PhpactorRootDebug] Home dir detected, using buffer path: ' .. file_dir)
            return file_dir
          end

          -- If the path matches the Transmit pattern, use the server path as the root
          local transmit_pattern = '/Users/.*/Library/Caches/Transmit/.-/(.-)/.*'
          local server_path = string.match(file_path, transmit_pattern)
          if server_path then
            -- Build the full path up to the server
            local transmit_base = string.match(file_path, '(/Users/.*/Library/Caches/Transmit/.-/' .. server_path .. ')')
            vim.notify('[PhpactorRootDebug] Transmit folder detected, using server as root: ' .. transmit_base)
            return transmit_base
          end

          -- Default: Look for 'controller' directory in the path
          if string.match(file_path, '/controller/') then
            local controller_root = string.match(file_path, '(.-/controller)/')
            vim.notify('[PhpactorRootDebug] Controller found, using as root: ' .. controller_root)
            return controller_root
          end

          -- If nothing else matches, fall back to cwd
          vim.notify('[PhpactorRootDebug] Using default CWD: ' .. cwd)
          return cwd
        end,
      },
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',
      'prettierd',
    })

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }
    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
