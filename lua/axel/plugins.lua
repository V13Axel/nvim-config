---------------------
-- Lazy bootstrapping
---------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


-----------------------
-- Package installation
-----------------------

local plugins = {
    -- Commenting support.
    { 'tpope/vim-commentary' },

    -- Swap text around
    { 'tommcdo/vim-exchange' },

    -- Notifications
    { import = 'axel.plugins._notify' },

    -- Add, change, and delete surrounding text.
    { import = 'axel.plugins._surround' },

    -- Pairs of handy bracket mappings, like [b and ]b.
    { 'tpope/vim-unimpaired' },

    -- %S replacements for case
    { 'tpope/vim-abolish' },

    -- Allow plugins to enable repeating of commands.
    { 'tpope/vim-repeat' },

    -- Add more languages.
    { 'sheerun/vim-polyglot' },

    -- Navigate seamlessly between Vim windows and Tmux panes.
    { 'christoomey/vim-tmux-navigator' },

    -- Jump to the last location when opening a file.
    { 'farmergreg/vim-lastplace' },

    -- Enable * searching with visually selected text.
    { 'nelstrom/vim-visual-star-search' },

    -- Automatically create parent dirs when saving.
    { 'jessarcher/vim-heritage' },

    -- Text objects for HTML attributes.
    { import = 'axel.plugins._vim-textobj-xmlattr' },

    -- Navigable tree of undo history
    { import = 'axel.plugins._undotree' },

    -- Automatically add closing brackets, quotes, etc.
    { 'windwp/nvim-autopairs',                       config = true },

    -- Add smooth scrolling to avoid jarring jumps
    { import = 'axel.plugins._neoscroll' },

    -- All closing buffers without closing the split window.
    { import = 'axel.plugins._bufdelete' },

    -- Split arrays and methods onto multiple lines, or join them back up.
    { import = 'axel.plugins._splitjoin' },

    -- -- Automatically fix indentation when pasting code.
    { import = 'axel.plugins._pasta' },

    -- Add git related info in the signs columns and popups
    { import = 'axel.plugins._gitsigns' },

    -- The best git plugin for neovim
    { import = 'axel.plugins._fugitive' },

    -- Quick-switch menu for swapping between 3-4 files
    { import = 'axel.plugins._harpoon' },

    -- Catppuccin theme
    { import = 'axel.plugins._catppuccin' },

    -- Improved syntax highlighting and a bunch more
    { import = 'axel.plugins._treesitter' },

    -- Show context in comments
    { 'JoosepAlviste/nvim-ts-context-commentstring', config = true },

    -- Provide lua context for vim builtin objects
    { import = 'axel.plugins._neodev' },

    -- Language servers
    { import = 'axel.plugins._lspconfig' },

    -- Autocomplete
    { import = 'axel.plugins._cmp' },

    -- Fuzzy finder
    { import = 'axel.plugins._telescope' },

    -- Chadtree file tree
    { import = 'axel.plugins._chadtree' },

    -- Lualine statusline
    { import = 'axel.plugins._lualine' },

    -- Show indent markers even on blank lines
    { import = 'axel.plugins._indent-blankline' },

    -- A free, open source PHP LSP
    { import = 'axel.plugins._phpactor' },

    -- A second brain, for free
    { import = 'axel.plugins._obsidian' },

    -- Run tests right from nvim!
    { import = 'axel.plugins._neotest' },

    -- Generate beautiful images of your code
    { import = 'axel.plugins._silicon' },

    -- [Ctrl+W, m] to (temporarily) maximize the current buffer
    { 'dhruvasagar/vim-zoom' },

    -- `gs` to convert symbols to their most common alternatives
    { import = 'axel.plugins._switch' },

    -- Jump to alternate files and more
    { import = 'axel.plugins._projectionist' },

    -- Cursor-inline command line and lot more
    { import = 'axel.plugins._noice' },

    -- Jump straight to Zeal docs from nvim
    { import = 'axel.plugins._zeavim' },

    -- Database ... in your editor
    { import = 'axel.plugins._dadbod' },

    -- Provides a bunch of Laravel-specific helpers
    { import = 'axel.plugins._laravel' },

    -- Enables movement in and between Blade files
    {
        'ricardoramirezr/blade-nav.nvim',
        ft = { 'blade', 'php' }
    },

    -- Load up a CSV and get a pretty view
    { import = 'axel.plugins._csv-view' },

    -- Debugging directly in Neovim
    { import = 'axel.plugins._dap' },

    -- Highlights colors directly in the editor
    { import = 'axel.plugins._nvim-highlight-colors' },
}

require("lazy").setup(plugins);
