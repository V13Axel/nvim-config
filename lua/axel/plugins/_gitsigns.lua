return {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('gitsigns').setup({
            signs = {
                add = { text = "┃" },
                change = { text = "┃" },
                delete = { text = "▁" },
                topdelete = { text = "▔" },
                changedelete = { text = "┃" },
                untracked = { text = "┃" },
            }
        })
        vim.keymap.set('n', '<leader>]h', function() require("gitsigns").next_hunk() end)
        vim.keymap.set('n', '<leader>[h', function() require("gitsigns").prev_hunk() end)
        vim.keymap.set('n', '<leader>gs', function() require("gitsigns").stage_hunk() end)
        vim.keymap.set('n', '<leader>gS', function() require("gitsigns").undo_stage_hunk() end)
        vim.keymap.set('n', '<leader>gp', function() require("gitsigns").preview_hunk() end)
        vim.keymap.set('n', '<leader>gb', function() require("gitsigns").blame_line() end)
    end
}
