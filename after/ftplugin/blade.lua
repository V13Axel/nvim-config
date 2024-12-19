vim.bo.commentstring = '{{-- %s --}}'

vim.keymap.set('n', '<leader>=', ':%!blade-formatter --stdin<CR>', { silent = true })
