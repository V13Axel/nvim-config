return {
    'KabbAmine/zeavim.vim',
    config = function()
        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'php' },
            command = 'Docset laravel'
        })

        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'blade' },
            command = 'Docset twcss'
        })

        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'rust' },
            command = 'Docset rust'
        })


        vim.keymap.set('n', 'gz', ':Zeavim<CR>', { silent = true })
    end
}
