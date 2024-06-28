return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set('n', '<leader>gg', function() vim.cmd('Git') end)
        vim.keymap.set('n', '<leader>gP', ":Git push<CR>", { silent = true })
    end
}
