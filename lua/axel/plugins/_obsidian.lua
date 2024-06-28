return {
    'epwalsh/obsidian.nvim',
    version = "*",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.opt.conceallevel = 1
        require("obsidian").setup({
            workspaces = {
                {
                    name = "Zettelkasten",
                    path = "~/Git/Zettelkasten",
                },
                {
                    name = "PV-Notes",
                    path = "~/Git/PV-Notes",
                },
                {
                    name = "Undying-Valor-Notes",
                    path = "~/Git/Undying-Valor-Notes",
                },
                {
                    name = "Jeannora",
                    path = "~/Git/Jeannora",
                }
            }
        })
    end,
}
