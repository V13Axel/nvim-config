return {
    "adalessa/laravel.nvim",
    dependencies = {
        "tpope/vim-dotenv",
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-neotest/nvim-nio",
    },
    cmd = { "Laravel" },
    keys = {
        { "<leader>la", function() Laravel.pickers.artisan() end,              desc = "Laravel: Open Artisan Picker" },
    },
    event = { "VeryLazy" },
    opts = {
        features = {
            pickers = {
                provider = "telescope",
            },
        },
    },
    config = true,
}
