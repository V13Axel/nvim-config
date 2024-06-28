return {
    'nvim-treesitter/nvim-treesitter',
    -- commit = "c579d186bec0a4af9d0741b235cfa0627ffd9f15",
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context'
    },
    config = function()
        require('treesitter-context').setup()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'comment',
                'css',
                'diff',
                'dockerfile',
                'git_config',
                'html',
                'javascript',
                'json',
                'lua',
                'php',
                'kdl',
                'rust',
                'vim',
                'regex',
                'bash',
                'markdown_inline',
            },
            auto_install = true,
            sync_install = true,
            highlight = {
                enable = true,

                -- NOTE: This will slow things down, if you need to re-enable it, make sure you know why.
                -- Disabled on 2024-03-13, because it's slowing down the editor.
                -- additional_vim_regex_highlighting = true,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    -- TODO: I'm not sure for this one.
                    scope_incremental = '<c-s>',
                    node_decremental = '<c-backspace>',
                },
            },
            textobjects = {
                lsp_interop = {
                    enable = true,
                    border = 'none',
                    floating_preview_opts = {},
                    peek_definition_code = {
                        ["<leader>df"] = "@function.outer",
                        ["<leader>dF"] = "@class.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>na'] = '@parameter.inner',
                        ['<leader>nf'] = '@function.outer',
                    },
                    swap_previous = {
                        ['<leader>pa'] = '@parameter.inner',
                        ['<leader>pf'] = '@function.outer',
                    }
                },
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['if'] = '@function.inner',
                        ['af'] = '@function.outer',
                        ['ia'] = '@parameter.inner',
                        ['aa'] = '@parameter.outer',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ['a/'] = '@comment.outer',
                        ['i/'] = '@comment.inner',
                        ['ii'] = '@conditional.inner',
                        ['ai'] = '@conditional.outer',
                        ['ix'] = '@attribute.inner',
                        ['ax'] = '@attribute.outer',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']f'] = '@function.outer',
                        [']]'] = '@class.outer',
                        [']a'] = '@parameter.inner',
                        [']i'] = '@conditional.outer',
                        [']/'] = '@comment.outer',
                        [']s'] = 'next_s'
                    },
                    goto_next_end = {
                        [']F'] = '@function.outer',
                        [']['] = '@class.outer',
                        [']A'] = '@parameter.inner',
                        [']I'] = '@conditional.outer',
                        [']?'] = '@comment.outer',
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer',
                        ['[['] = '@class.outer',
                        ['[a'] = '@parameter.inner',
                        ['[i'] = '@conditional.outer',
                        ['[/'] = '@comment.outer',
                    },
                    goto_previous_end = {
                        ['[F'] = '@function.outer',
                        ['[]'] = '@class.outer',
                        ['[A'] = '@parameter.inner',
                        ['[I'] = '@conditional.outer',
                        ['[?'] = '@comment.outer',
                    },
                },
            }
        })
        local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

        -- Repeat movement with ; and ,
        -- ensure ; goes forward and , goes backward regardless of the last direction
        -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}
