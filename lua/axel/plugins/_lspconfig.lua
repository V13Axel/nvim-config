return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'nvimtools/none-ls.nvim',
        'jay-babu/mason-null-ls.nvim',
    },
    config = function()
        -- Point to the spot in a line where an LSP error occurs
        require("lsp_lines").setup()

        -- Disable virtual_text since it's redundant due to lsp_lines.
        vim.diagnostic.config({
            virtual_text = false,
        })

        vim.keymap.set(
            "",
            "<leader>l",
            require("lsp_lines").toggle,
            { desc = "Toggle lsp_lines" }
        )


        -- Managest external tooling
        require('mason').setup()

        -- Enable the following language servers
        local servers = {
            'pyright',
            'tsserver',
            'lua_ls',
            'emmet_ls',
            'tailwindcss',
            'intelephense',
            -- 'openscad_lsp',
            'bashls',
            -- 'phpactor',
        }

        --
        -- nvim-cmp supports additional completion capabilities
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

        require('mason-lspconfig').setup {
            ensure_installed = servers,
        }

        if not (string.find(os.getenv('HOME'), "com.termux")) then
            table.insert(servers, 'rust_analyzer')
            table.insert(servers, 'clangd')
            -- table.insert(servers, 'gdscript')
        end

        --
        -- LSP settings.
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(_, bufnr)
            -- NOTE: Remember that lua is a real programming language, and as such it is possible
            -- to define small helper and utility functions so you don't have to repeat yourself
            -- many times.
            --
            -- In this case, we create a function that lets us more easily define mappings specific
            -- for LSP related items. It sets the mode, buffer and description for us each time.
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end

                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            nmap('gr', require('telescope.builtin').lsp_references)
            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            -- See `:help K` for why this keymap
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

            -- Lesser used LSP functionality
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                if vim.lsp.buf.format then
                    vim.lsp.buf.format()
                elseif vim.lsp.buf.formatting then
                    vim.lsp.buf.formatting()
                end
            end, { desc = 'Format current buffer with LSP' })

            vim.keymap.set('n', '<leader>=', ':Format<CR>', { buffer = bufnr, desc = 'Format buffer', silent = true })

            -- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
        end

        require("lspconfig").clangd.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "clangd", "--offset-encoding=utf-16", },
        }

        require('lspconfig').bashls.setup {
            filetypes = { 'sh', 'zsh' },
        }

        for _, lsp in ipairs(servers) do
            require('lspconfig')[lsp].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end

        -- Example custom configuration for lua
        --
        -- Make runtime files discoverable to the server
        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, 'lua/?.lua')
        table.insert(runtime_path, 'lua/?/init.lua')

        require('lspconfig').intelephense.setup {
            init_options = {
                licenceKey = 'CHANGEME'
            }
        }

        require('lspconfig').emmet_ls.setup {
            capabilities = capabilities,
            filetypes = { 'blade', 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
        }

        require('lspconfig').gdscript.setup {
            on_attach = function(client, bufnr)
                -- vim.opt_local.foldmethod = 'expr'
                vim.opt_local.tabstop = 4
                on_attach(client, bufnr)
            end,
            capabilities = capabilities,
            filetypes = { 'gdscript', 'gd', 'gdscript3' },
            flags = { debounce_text_changes = 150 },
        }

        require('lspconfig').lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                        version = 'LuaJIT',
                        -- Setup your lua path
                        path = runtime_path,
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = { library = vim.api.nvim_get_runtime_file('', true) },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = { enable = false },
                },
            },
        }


        -- null-ls
        -- require('null-ls').setup({
        --     sources = {
        --         require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
        --         require('null-ls').builtins.formatting.prettierd,
        --     },
        -- })

        require('mason-null-ls').setup({ automatic_installation = true })
    end,
}
