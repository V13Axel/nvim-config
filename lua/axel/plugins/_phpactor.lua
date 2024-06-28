return {
    'phpactor/phpactor',
    ft = 'php',
    build = 'composer install --no-dev --optimize-autoloader',
    config = function()
        vim.keymap.set('n', '<leader>pm', ':PhpactorContextMenu<CR>', { silent = true })
        vim.keymap.set('n', '<leader>pn', ':PhpactorClassNew<CR>', { silent = true })
    end
}

-- return {
--     "gbprod/phpactor.nvim",
--     build = function()
--         require("phpactor.handler.update")()
--     end,
--     dependencies = {
--         "nvim-lua/plenary.nvim",
--         "neovim/nvim-lspconfig"
--     },
--     opts = {

--     },
-- }
