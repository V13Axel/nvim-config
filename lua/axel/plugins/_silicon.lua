return {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = function()
        require("silicon").setup({
            -- Configuration here, or leave empty to use defaults
            font = "IosevkaTerm Nerd Font=34;Noto Color Emoji=34",
            theme = "Catppuccin-mocha",
            -- background = "#181825",
            no_window_controls = true,
            no_round_corner = false,

            language = function()
                local ft = vim.bo.filetype;

                if ft == "php" then
                    return "PHP Source"
                end

                return ft
            end,

            output = function()
                return "~/Pictures/Screenshots/flameshot/" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
            end,
        })
    end
}
