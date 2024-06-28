return {
    'tpope/vim-dadbod',
    'kristijanhusak/vim-dadbod-completion',
    'kristijanhusak/vim-dadbod-ui',
    config = function()
        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { 'sql' },
            callback = function()
                vim.keymap.set('n', '<m-1>', vim.cmd.DBUI, { buffer = true })
                vim.keymap.set('n', '<leader>=', '%! sleek<CR>', { silent = true })
            end
        })
    end
}
