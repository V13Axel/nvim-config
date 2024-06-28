vim.opt.termguicolors = true

-- Space is my leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local silentmap = function(mode, key, command, extraoptions)
    local options = { silent = true }

    if extraoptions then
        for optionkey, option in pairs(extraoptions) do options[optionkey] = option end
    end

    vim.keymap.set(mode, key, command, options)
end

local silentimap = function(key, command, extraoptions)
    silentmap('i', key, command, extraoptions)
end

local silentnmap = function(key, command, extraoptions)
    silentmap('n', key, command, extraoptions)
end

local silentvmap = function(key, command, extraoptions)
    silentmap('v', key, command, extraoptions)
end


-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')

-- Disable annoying command line typo.
vim.keymap.set('n', 'q:', ':q')
vim.keymap.set('n', "Q", "<nop>")

-- Paste replace visual selection without copying it.
vim.keymap.set('v', 'p', '"_dP')

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set('i', ';;', '<Esc>A;')
vim.keymap.set('n', '<leader>;', 'msA;<Esc>`s')
vim.keymap.set('i', ',,', '<Esc>A,')
vim.keymap.set('n', '<leader>,', 'mcA,<Esc>`c')

-- Quickly clear search highlighting.
vim.keymap.set('n', '<Leader>k', ':nohlsearch<CR>', { silent = true })

-- Open the current file in the default program (on Mac this should just be just `open`).
vim.keymap.set('n', '<Leader>x', ':!xdg-open %<CR><CR>', { silent = true })
vim.keymap.set('n', '<leader>ddh',
    'Odd("Here in " . __FILE__ . (__FUNCTION__ ? " in " . __FUNCTION__ : "") . " at line " . __LINE__);')

-- Move lines up and down.
silentimap('<A-j>', '<Esc>:move .+1<CR>==gi')
silentimap('<A-k>', '<Esc>:move .-2<CR>==gi')
silentnmap('<A-j>', ':move .+1<CR>==')
silentnmap('<A-k>', ':move .-2<CR>==')
silentvmap('<A-j>', ":move '>+1<CR>gv=gv")
silentvmap('<A-k>', ":move '<-2<CR>gv=gv")

-- Resize
vim.keymap.set('n', '<A-minus>', ':resize -2<CR>')
vim.keymap.set('n', '<A-plus>', ':resize +2<CR>')

-- Better up/down jumping, keeps cursor centered
vim.keymap.set('n', "J", "mzJ`z")
vim.keymap.set('n', "n", "nzzzv")
vim.keymap.set('n', "N", "Nzzzv")


vim.keymap.set('n', '<leader>r', ':%s///g<Left><Left>')
vim.keymap.set('x', '<leader>r', ':s///g<Left><Left>')

-- Window splits using leader v and h
vim.keymap.set('n', '<leader>v', ':vsplit<CR>')
vim.keymap.set('n', '<leader>h', ':split<CR>')
vim.keymap.set('n', '<leader>o', ':only<CR>')

-- Resize window splits with Alt
vim.keymap.set('n', '<M-left>', "<c-w>5<")
vim.keymap.set('n', '<M-right>', "<c-w>5>")
vim.keymap.set('n', '<M-up>', "<c-W>-")
vim.keymap.set('n', '<M-down>', "<c-W>+")

-- Toggle case and start typing, e.g. `<leader>iget` -> `property` -> `getProperty`
vim.keymap.set('n', '<leader>i', '~hi')

-- Remove selection and toggle case. e.g. `vtP<leader>I` -> `getProperty` -> `property`
vim.keymap.set('v', '<leader>I', 'd~h')

-- GH CLI
silentnmap('<leader>ghpv', ':!gh pr view --web<CR>')
silentnmap('<leader>ghpo', ':!gh pr view --web<CR>')
silentnmap('<leader>ghpr', ':!gh pr ready<CR>')
silentnmap('<leader>ghpm', ':!gh pr merge -sd<CR>')

-- Quickfix shortcuts
vim.keymap.set('n', 'gq', ':cc<CR>zt')
vim.keymap.set('n', 'gE', ':ccl<CR>')

-- Save without command
vim.keymap.set('n', '<leader>s', function() vim.api.nvim_command('write') end)

-- New tab
vim.keymap.set('n', '<C-t>', vim.cmd.tabnew, { silent = true })

-- HTML siblings
silentnmap(']S', function() require('jump-tag').jumpNextSibling() end)
silentnmap('[S', function() require('jump-tag').jumpPrevSibling() end)

-- [[ Highlight on yank ]]
-- Note ... I realize this isn't a keybind, _technically_.
-- This just seemed like the best place for this
--
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
