local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })
end

return {

    { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            'j-hui/fidget.nvim',
        },

        config = function()
            -- Setup mason so it can manage external tooling
            require('mason').setup()

            -- Enable the following language servers
            -- Feel free to add/remove any LSPs that you want here. They will automatically be installed
            local servers = {
                'docker_compose_language_service',
                'dockerls',
                'gopls',
                'html',
                'lua_ls',
                'phpactor',
                'tailwindcss',
                'ts_ls',
                'volar',
                'yamlls',
            }

            -- Ensure the servers above are installed
            require('mason-lspconfig').setup {
                ensure_installed = servers,
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup {
                            on_attach = on_attach,
                            capabilities = capabilities,
                        }
                    end,
                }
            }

            -- nvim-cmp supports additional completion capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- go
            require('lspconfig').gopls.setup({
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)

                    vim.api.nvim_create_autocmd("BufWritePre", {
                        pattern = "*.go",
                        callback = function()
                            vim.lsp.buf.code_action({
                                context = { only = { "source.organizeImports" } },
                                apply = true,
                            })
                        end,
                    })
                end,
            })

            -- lua
            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, 'lua/?.lua')
            table.insert(runtime_path, 'lua/?/init.lua')

            require('lspconfig').lua_ls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                            path = runtime_path,
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file('', true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            }

            -- tailwind
            require('lspconfig').phpactor.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = {
                    "php",
                },
            }

            -- tailwind
            require('lspconfig').tailwindcss.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = {
                    "html",
                    "javascript",
                    "php",
                    "typescript",
                    "vue",
                },
            }

            -- vue
            require('lspconfig').volar.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = {
                    "javascript",
                    "typescript",
                    "vue",
                },
            })
            require('lspconfig').ts_ls.setup {
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = "/opt/homebrew/lib/node_modules/@vue/typescript-plugin",
                            languages = { "javascript", "typescript", "vue" },
                        },
                    },
                },
                filetypes = {
                    "javascript",
                    "typescript",
                    "vue",
                },
            }
        end,
    },

    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            -- nvim-cmp setup
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'

            cmp.setup {
                view = {
                    entries = 'native',
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ['<M-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ['<M-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ['<Tab>'] = cmp.mapping.confirm { select = true },
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'neorg' },
                },
            }
        end,
    },

    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
    },

    { -- Use Mason formatters
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        opts = {
            formatters_by_ft = {
                go = { 'gofmt', 'goimports' },
                javascript = { { 'prettierd', 'prettier' } },
                json = { 'jq' },
                lua = { 'stylua' },
                php = { 'php_cs_fixer' },
                ['*'] = { 'trim_newlines', 'trim_whitespace' },
            },
        },
    },
}
