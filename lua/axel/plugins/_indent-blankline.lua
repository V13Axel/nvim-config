return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
        require('ibl').setup {
            indent = {
                char = '┊'
            },
            scope = {
                show_start = false,
                show_end = false,
            }
        }
    end
}
