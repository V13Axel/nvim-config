return {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    opts = {
        interactions = {
            chat = {
                adapter = "opencode"
            }
        }
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<A-9>", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle CodeCompanion Chat" },
        { "<C-a>", "<cmd>CodeCompanionActions<cr>", desc = "Open CodeCompanion Actions" },
    },
}
