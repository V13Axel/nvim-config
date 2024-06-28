return {
    "declancm/cinnamon.nvim",
    config = function()
        local cinnamon = require("cinnamon")

        cinnamon.setup()

        vim.keymap.set("n", "<C-U>", function() cinnamon.scroll("<C-U>zz") end)
        vim.keymap.set("n", "<C-D>", function() cinnamon.scroll("<C-D>zz") end)
    end
}
