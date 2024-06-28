return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        { 'zolrath/telescope-projectionist.nvim',     branch = 'local-get-default' },
        'nvim-telescope/telescope-live-grep-args.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-telescope/telescope-ui-select.nvim'
    },
    config = function()
        local actions = require('telescope.actions')

        local base1 = "#2D3145"
        local base2 = "#32364A"
        local colors = require("catppuccin.palettes").get_palette()
        require("catppuccin.lib.highlighter").syntax({
            TelescopePromptNormal = { fg = colors.text, bg = base1 },
            TelescopePromptBorder = { fg = base1, bg = base1 },
            TelescopePromptTitle = { fg = colors.subtext1, bg = base1 },

            TelescopeResultsNormal = { fg = colors.subtext1, bg = base1 },
            TelescopeResultsBorder = { fg = base1, bg = base1 },
            TelescopeResultsTitle = { fg = base1, bg = base1 },

            TelescopePreviewNormal = { bg = base2 },
            TelescopePreviewBorder = { fg = base2, bg = base2 },
            TelescopePreviewTitle = { fg = base2, bg = base2 },

            -- TelescopeMultiSelection = { fg = colors.text, bg = colors.surface1, style = { "bold" }  },
            -- TelescopeSelection = { fg = colors.text, bg = colors.surface1, style = { "bold" } },

            -- TelescopePromptNormal = { bg = colors.mantle },
            -- TelescopeResultsNormal = { bg = colors.mantle },
            -- TelescopePreviewNormal = { bg = colors.mantle },
        })

        require('telescope').setup({
            defaults = {
                path_display = {
                    filename_first = {
                        reverse_directories = false
                    },
                    truncate = 1,
                },
                prompt_prefix = '   ',
                selection_caret = '  ',
                mappings = {
                    i = {
                        ['<esc>'] = actions.close,
                        ['<C-Down>'] = actions.cycle_history_next,
                        ['<C-Up>'] = actions.cycle_history_prev,
                    },
                },
                layout_strategy = 'vertical',
                file_ignore_patterns = { '.git/' },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                buffers = {
                    previewer = false,
                    layout_config = {
                        width = 80,
                    },
                },
                oldfiles = {
                    prompt_title = 'History',
                },
                lsp_references = {
                    previewer = false,
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_cursor {
                        -- even more opts
                    },
                    specific_opts = {
                        -- disable the custom builtin "codeactions" display
                        codeactions = false,
                    }
                }
            }
        })

        require('telescope').load_extension('ui-select')
        require('telescope').load_extension('fzf')
        require('telescope').load_extension('live_grep_args')
        require('telescope').load_extension('projectionist')

        vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files)
        vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files)
        vim.keymap.set('n', '<leader>F',
            [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
        vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
        vim.keymap.set('n', '<leader>G', require('telescope').extensions.live_grep_args.live_grep_args)
        -- vim.keymap.set('n', '<leader>h', require('telescope.builtin').oldfiles)
        vim.keymap.set('n', '<leader>S', function() require('telescope.builtin').lsp_document_symbols({ symbols='method' }) end)

        -- Fuzzy search in current buffer
        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer]' })
    end,
}
