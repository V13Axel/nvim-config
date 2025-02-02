return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")

        dapui.setup({
            layouts = {
                {
                    elements = {
                        { id = "repl", size = 1 },
                    },
                    position = "top",
                    size = 1,
                },
                {
                    elements = {
                        { id = "scopes",      size = 0.60 },
                        { id = "stacks",      size = 0.15 },
                        { id = "breakpoints", size = 0.10 },
                    },
                    position = "left",
                    size = 70,
                },
            }
        })

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        dap.adapters.php = {
            type = 'executable',
            command = 'node',
            args = { '/home/axel/Git/vscode-php-debug/out/phpDebug.js' }
        }

        dap.configurations.php = {
            {
                type = 'php',
                request = 'launch',
                name = 'Listen for Xdebug',
                port = 9003,
                pathMappings = {
                    ['/var/www/html'] = "${workspaceFolder}",
                },
            }
        }

        vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint)
        vim.keymap.set('n', '<leader>dT', dapui.toggle)
        vim.keymap.set('n', '<leader>dc', dap.continue)
        vim.keymap.set('n', '<leader>do', dap.step_over)
        vim.keymap.set('n', '<leader>di', dap.step_into)
        vim.keymap.set('n', '<leader>du', dap.step_out)
        vim.keymap.set('n', '<leader>dB', dap.set_breakpoint)
        vim.keymap.set('n', '<leader>dl',
            function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end)
        vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
            require('dap.ui.widgets').hover()
        end)
        vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
            require('dap.ui.widgets').preview()
        end)
        vim.keymap.set('n', '<Leader>df', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.frames)
        end)
        vim.keymap.set('n', '<Leader>ds', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.scopes)
        end)
    end
}
