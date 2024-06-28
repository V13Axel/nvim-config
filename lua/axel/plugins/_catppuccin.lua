return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
        vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
        require("catppuccin").setup({
            transparent_background = true,
            integrations = {
                telescope = true,
            },
            no_italic = true,
        })

        vim.api.nvim_command("colorscheme catppuccin")

        vim.api.nvim_set_hl(0, 'NormalFloat', {
            bg = '#313244',
        })

        vim.api.nvim_set_hl(0, 'FloatBorder', {
            fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
            bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
        })
    end
}
