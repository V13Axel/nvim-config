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
                    path = "~/ObsidianVaults/Zettelkasten",
                },
                {
                    name = "PV-Notes",
                    path = "~/ObsidianVaults/PV-Notes",
                },
                {
                    name = "Undying-Valor-Notes",
                    path = "~/ObsidianVaults/Undying-Valor-Notes",
                },
                {
                    name = "Jeannora",
                    path = "~/ObsidianVaults/Jeannora",
                }
            }
        })
    end,
}
