return {
    'tpope/vim-surround',
    config = function()
        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'php' },
            command = 'let b:surround_{char2nr("d")} = "dd(\r)"'
        })

        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'php' },
            command = 'let b:surround_{char2nr("u")} = "dump(\r)"'
        })

        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'php' },
            command = 'let b:surround_{char2nr("c")} = "collect(\r)"'
        })

        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'blade' },
            command = 'let b:surround_{char2nr("d")} = "@dd(\r)"'
        })

        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'blade' },
            command = 'let b:surround_{char2nr("u")} = "@dump(\r)"'
        })

        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'blade' },
            command = 'let b:surround_{char2nr("!")} = "{!! \r !!}"'
        })

        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'blade' },
            command = 'let b:surround_{char2nr("{")} = "{{ \r }}"'
        })

        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'markdown' },
            command = 'let b:surround_{char2nr("~")} = "~~\r~~"'
        })

        -- Come back to this later.
        -- vim.keymap.set('n', 'dsf', 'ds)db')
        -- vim.keymap.set('n', 'csf', '[(cb')
    end
}
