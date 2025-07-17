return {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod',                     lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    init = function()
        vim.keymap.set(
            'n',
            '<M-D>',
            function()
                vim.api.nvim_command('tab DBUI')
            end,
            { silent = true }
        )
        vim.g.db_ui_use_nerd_fonts = 1
    end
}
