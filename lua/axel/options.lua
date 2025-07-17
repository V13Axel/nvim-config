vim.opt.expandtab = true                        -- Use spaces instead of tabs
vim.opt.shiftwidth = 4                          -- Make indention 4 spaces wide
vim.opt.tabstop = 4                             -- Use 4 spaces for tabbing
vim.opt.softtabstop = 4                         -- Use 4 spaces when showing tab chars

vim.opt.smartindent = true                      -- Attempts to indent smartly.

vim.opt.breakindent = true                      -- Wrapped text maintains visual indentation.

vim.opt.updatetime = 250                        -- Decrease update time between swap files.

vim.wo.signcolumn = 'yes:1'                     -- Draw the "sign column" at all times, 1 char wide.

vim.opt.wrap = false                            -- Disable text wrapping by default

vim.opt.number = true                           -- Enable line numbers
vim.opt.relativenumber = true                   -- Make line numbers relative for ease of jumping around

vim.opt.wildmode = 'longest:full,full'          -- Tab to complete the longest match in the : command line

vim.opt.title = true                            -- Set the title of the terminal window based on context

vim.opt.mouse = 'a'                             -- enable mouse for all modes

vim.opt.ignorecase = true                       -- Ignore case in patterns by default
vim.opt.smartcase = true                        -- Override ignoring case if the pattern contains uppercase

vim.opt.list = true                             -- 'list' helps visualize tabs, spaces, and line endings
vim.opt.listchars = { tab = '» ', trail = '·' } -- Specify characters to use for those
vim.opt.fillchars:append({ eob = ' ' })         -- remove the ~ from end of buffer

vim.opt.splitbelow = true                       -- Copied from Jess Archer via Laracasts tbh.
vim.opt.splitright = true                       -- Not sure why both of these are true.

vim.opt.scrolloff = 8                           -- Add an 8-line gap at the top and bottom of Vim when scrolling
vim.opt.sidescrolloff = 8                       -- Add an 8-column gap at the right and left of Vim when scrolling

vim.opt.clipboard = 'unnamedplus'               -- Use system clipboard

vim.opt.confirm = true                          -- ask for confirmation instead of erroring

vim.opt.undofile = true                         -- persistent undo
vim.opt.backup = true                           -- automatically save a backup file
vim.opt.backupdir:remove('.')                   -- keep backups out of the current directory

vim.opt.completeopt = 'menuone,noselect'        -- Use a popup menu for : command completion, even if only one item
vim.opt.swapfile = false                        -- Don't create a .swp file when opening a file

vim.opt.exrc = true                             -- Look for `.nvim.lua` and similar project-specific init files
