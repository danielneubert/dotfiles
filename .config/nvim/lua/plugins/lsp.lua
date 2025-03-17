local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    vim.api.nvim_clear_autocmds({ buffer = bufnr, event = "BufWritePre" })

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })
end



return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            require('mason').setup()

            -- Enable the following language servers
            local servers = {
                'docker_compose_language_service',
                'dockerls',
                'gopls',
                'html',
                'lua_ls',
                -- 'phpactor',
                'intelephense',
                'tailwindcss',
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
                        }
                    end,
                }
            }

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
            --
            -- -- php
            -- require('lspconfig').phpactor.setup {
            --     on_attach = on_attach,
            --     capabilities = vim.lsp.protocol.make_client_capabilities(),
            --     filetypes = {
            --         "php",
            --     },
            -- }

            -- php
            require('lspconfig').intelephense.setup {
                on_attach = on_attach,
                filetypes = {
                    "php",
                },
            }

            -- tailwind
            require('lspconfig').tailwindcss.setup {
                on_attach = on_attach,
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
                filetypes = {
                    "javascript",
                    "typescript",
                    "vue",
                },
                init_options = {
                    vue = {
                        hybridMode = false,
                    },
                },
            })
        end,
    },
}
