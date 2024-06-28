return {
    'AndrewRadev/switch.vim',
    config = function()
        -- Set mapping to "-"
        -- vim.g.switch_mapping = '-'

        -- vim.keymap.set('n', "<leader>ae", ":Switch")

        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'php' },
            callback = function()
                -- vim.cmd [[
                --     let b:switch_custom_definitions = [
                --           \   {
                --           \     '\(\k\+=\){\([[:keyword:].]\+\)}':      '\1{`${\2}`}',
                --           \     '\(\k\+=\){`${\([[:keyword:].]\+\)}`}': '\1{\2}',
                --           \   }
                --           \ ]
                -- ]]
                vim.b.switch_custom_definitions = {
                    -- Experiment: Account for third argument of Arr::get(), turn it into null-coalesce
                    -- {
                    --     ["\\(\\$[[:keyword:].]\\+\\)\\[\\(.\\{-}\\)\\] ?? \\(.\\{-}\\)\\([;|,|\\\\)]\\)"] = 'Arr::get(\\1, \\2, \\3)\\4',
                    --     ["Arr::get(\\([\\$[:keyword:].]\\+\\), \\(.\\{-}\\), \\(.\\{-}\\))\\([;|,|\\\\)]\\)"] = '\\1\\[\\2\\] ?? \\3\\4',
                    -- },
                    {
                        ["\\(\\$[[:keyword:].]\\+\\)\\[\\(.*\\)]"] = 'Arr::get(\\1, \\2)',
                        ["Arr::get(\\(\\$[[:keyword:].]\\+\\), \\([\"\\|\'].*[\"\\|\']\\))"] = '\\1\\[\\2\\]',
                    }
                }
            end
        })

        -- In markdown files, switch between - [ ] and - [x]
        -- The switch.vim wiki says that's done with:
        --autocmd FileType markdown let b:switch_custom_definitions =
        -- \ [
        -- \   { '\v^(\s*[*+-] )?\[ \]': '\1[x]',
        -- \     '\v^(\s*[*+-] )?\[x\]': '\1[-]',
        -- \     '\v^(\s*[*+-] )?\[-\]': '\1[ ]',
        -- \   },
        -- \   { '\v^(\s*\d+\. )?\[ \]': '\1[x]',
        -- \     '\v^(\s*\d+\. )?\[x\]': '\1[-]',
        -- \     '\v^(\s*\d+\. )?\[-\]': '\1[ ]',
        -- \   },
        -- \ ]
        --
        -- This is the Lua equivalent.
        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'markdown' },
            callback = function()
                vim.b.switch_custom_definitions = {
                    {
                        ["\\v^(\\s*[*+-] )?\\[ \\]"] = '\1[x]',
                        ["\\v^(\\s*[*+-] )?\\[x\\]"] = '\1[-]',
                        ["\\v^(\\s*[*+-] )?\\[-\\]"] = '\1[ ]',
                    },
                    {
                        ["\\v^(\\s*\\d+\\. )?\\[ \\]"] = '\1[x]',
                        ["\\v^(\\s*\\d+\\. )?\\[x\\]"] = '\1[-]',
                        ["\\v^(\\s*\\d+\\. )?\\[-\\]"] = '\1[ ]',
                    }
                }
            end
        })
    end
}
