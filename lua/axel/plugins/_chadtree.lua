return {
    'ms-jpq/chadtree',
    config = function()
        vim.keymap.set("n", "<m-1>", vim.cmd.CHADopen)
        vim.keymap.set("i", "<m-1>", function()
            vim.cmd('stopinsert');
            vim.cmd.CHADopen();
        end)
    end
}
