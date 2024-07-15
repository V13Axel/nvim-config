return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
        vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
        require("catppuccin").setup({
            transparent_background = true,
            integrations = {
                telescope = {
                    enabled = true,
                },
                harpooon = true,
                coc_nvim = true,
                neotest = true,
                noice = true,
                notify = true,
            },
            no_italic = true,
            no_underline = true,
            no_bold = true,
            custom_highlights = function(colors)
                return {
                    ["@bracket_start"] = { fg = colors.sky },
                    ["@bracket_end"] = { fg = colors.sky },
                }
            end
        })

        vim.api.nvim_command("colorscheme catppuccin")

        vim.api.nvim_set_hl(0, 'NormalFloat', {
            bg = '#313244',
        })

        vim.api.nvim_set_hl(0, 'FloatBorder', {
            fg = vim.api.nvim_get_hl(0, { name = 'NormalFloat' }).background,
            bg = vim.api.nvim_get_hl(0, { name = 'NormalFloat' }).background,
        })
    end
}
