return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
        'nvim-treesitter/nvim-treesitter-context'
    },
    config = function()
        -- blade is now a tier-2 parser in nvim-treesitter main; no custom registration needed.
        vim.filetype.add({
            pattern = {
                ['.*%.blade%.php'] = 'blade',
            }
        })

        -- Install parsers (no-op if already installed)
        require('nvim-treesitter').install({
            'comment',
            'css',
            'diff',
            'dockerfile',
            'dtd',      -- required by xml
            'git_config',
            'html',
            'blade',
            'javascript',
            'json',
            'lua',
            'php',
            'php_only',
            'kdl',
            'rust',
            'sql',
            'vim',
            'regex',
            'bash',
            'markdown',
            'markdown_inline',
            'xml',
        })

        -- Enable highlighting and indentation per filetype
        vim.api.nvim_create_autocmd('FileType', {
            pattern = {
                'css', 'diff', 'dockerfile', 'git_config',
                'html', 'blade', 'javascript', 'json', 'lua',
                'php', 'php_only', 'kdl', 'rust', 'sql', 'vim',
                'regex', 'bash', 'markdown', 'markdown_inline',
                'xml', 'dtd',
            },
            callback = function()
                vim.treesitter.start()
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        -- treesitter-context
        require('treesitter-context').setup()

        -- textobjects: configure select and move behaviour
        require("nvim-treesitter-textobjects").setup {
            select = {
                lookahead = true,
            },
            move = {
                set_jumps = true,
            },
        }

        -- textobjects: select
        local select = require("nvim-treesitter-textobjects.select")
        local sel = function(q) return function() select.select_textobject(q, "textobjects") end end
        vim.keymap.set({ "x", "o" }, "if", sel("@function.inner"))
        vim.keymap.set({ "x", "o" }, "af", sel("@function.outer"))
        vim.keymap.set({ "x", "o" }, "ia", sel("@parameter.inner"))
        vim.keymap.set({ "x", "o" }, "aa", sel("@parameter.outer"))
        vim.keymap.set({ "x", "o" }, "ac", sel("@class.outer"))
        vim.keymap.set({ "x", "o" }, "ic", sel("@class.inner"))
        vim.keymap.set({ "x", "o" }, "a/", sel("@comment.outer"))
        vim.keymap.set({ "x", "o" }, "i/", sel("@comment.inner"))
        vim.keymap.set({ "x", "o" }, "ii", sel("@conditional.inner"))
        vim.keymap.set({ "x", "o" }, "ai", sel("@conditional.outer"))
        vim.keymap.set({ "x", "o" }, "ix", sel("@attribute.inner"))
        vim.keymap.set({ "x", "o" }, "ax", sel("@attribute.outer"))

        -- textobjects: swap
        local swap = require("nvim-treesitter-textobjects.swap")
        vim.keymap.set("n", "<leader>na", function() swap.swap_next("@parameter.inner") end)
        vim.keymap.set("n", "<leader>nf", function() swap.swap_next("@function.outer") end)
        vim.keymap.set("n", "<leader>pa", function() swap.swap_previous("@parameter.inner") end)
        vim.keymap.set("n", "<leader>pf", function() swap.swap_previous("@function.outer") end)

        -- textobjects: move
        local move = require("nvim-treesitter-textobjects.move")
        local mn = function(q) return function() move.goto_next_start(q, "textobjects") end end
        local me = function(q) return function() move.goto_next_end(q, "textobjects") end end
        local mp = function(q) return function() move.goto_previous_start(q, "textobjects") end end
        local mpe = function(q) return function() move.goto_previous_end(q, "textobjects") end end

        vim.keymap.set({ "n", "x", "o" }, "]f",  mn("@function.outer"))
        vim.keymap.set({ "n", "x", "o" }, "]]",  mn("@class.outer"))
        vim.keymap.set({ "n", "x", "o" }, "]a",  mn("@parameter.inner"))
        vim.keymap.set({ "n", "x", "o" }, "]i",  mn("@conditional.outer"))
        vim.keymap.set({ "n", "x", "o" }, "]/",  mn("@comment.outer"))

        vim.keymap.set({ "n", "x", "o" }, "]F",  me("@function.outer"))
        vim.keymap.set({ "n", "x", "o" }, "][",  me("@class.outer"))
        vim.keymap.set({ "n", "x", "o" }, "]A",  me("@parameter.inner"))
        vim.keymap.set({ "n", "x", "o" }, "]I",  me("@conditional.outer"))
        vim.keymap.set({ "n", "x", "o" }, "]?",  me("@comment.outer"))

        vim.keymap.set({ "n", "x", "o" }, "[f",  mp("@function.outer"))
        vim.keymap.set({ "n", "x", "o" }, "[[",  mp("@class.outer"))
        vim.keymap.set({ "n", "x", "o" }, "[a",  mp("@parameter.inner"))
        vim.keymap.set({ "n", "x", "o" }, "[i",  mp("@conditional.outer"))
        vim.keymap.set({ "n", "x", "o" }, "[/",  mp("@comment.outer"))

        vim.keymap.set({ "n", "x", "o" }, "[F",  mpe("@function.outer"))
        vim.keymap.set({ "n", "x", "o" }, "[]",  mpe("@class.outer"))
        vim.keymap.set({ "n", "x", "o" }, "[A",  mpe("@parameter.inner"))
        vim.keymap.set({ "n", "x", "o" }, "[I",  mpe("@conditional.outer"))
        vim.keymap.set({ "n", "x", "o" }, "[?",  mpe("@comment.outer"))

        -- lsp_interop was removed upstream; use native LSP hover instead
        vim.keymap.set("n", "<leader>df", vim.lsp.buf.hover, { desc = "LSP hover (peek definition)" })
        vim.keymap.set("n", "<leader>dF", vim.lsp.buf.hover, { desc = "LSP hover (peek class)" })

        -- Repeat movement with ; and ,
        -- vim way: ; goes to the direction you were moving.
        local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}
