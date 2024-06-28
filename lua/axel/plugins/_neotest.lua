-- If ~/Git/neotest-pest exists, we want to use that instead of "V13Axel/neotest-pest"
local neotest_pest = "V13Axel/neotest-pest"

if vim.fn.filereadable(vim.fn.expand("~/Git/neotest-pest/.gitignore")) == 1 then
    neotest_pest = { dir = "~/Git/neotest-pest" }
end

return {
    'nvim-neotest/neotest',
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "rouge8/neotest-rust",
        "olimorris/neotest-phpunit",
        neotest_pest,
    },
    config = function()
        require('neotest').setup({
            -- log_level = vim.log.levels.DEBUG,
            consumers = {
                -- lualine = function(client)
                --     client.listeners.started = function(adapter_id, results, partial)
                --         if partial then
                --             return
                --         end


                --     end
                -- end,
                notify = function(client)
                    client.listeners.results = function(adapter_id, results, partial)
                        -- Partial results can be very frequent
                        if partial then
                            return
                        end

                        -- If the current buffer is the neotest summary, we will already have this information
                        -- if vim.api.nvim_buf_get_name(0):match("Neotest summary") then
                        --     return
                        -- end

                        -- If the current buffer is a test, assume we need no notification
                        -- if vim.api.nvim_buf_get_name(0):match("Test.php") then
                        --     return
                        -- end

                        -- `results` is a table that looks like this:
                        -- {
                        --     ["tests/Feature/CreateJobFromSourceTest.php::creates required fields even when empty"] = {
                        --       errors = {},
                        --       output = "/tmp/nvim.axel/G3ZglF/2",
                        --       status = "failed"
                        --     },
                        --     ["tests/Feature/AppBootsTest.php::can reach the database"] = {
                        --         output = "/tmp/nvim.axel/G3ZglF/2",
                        --         output_file = "storage/app/pest-20240411-091912",
                        --         short = "PASSED | it can reach the database",
                        --         status = "passed"
                        --     }
                        -- }
                        --
                        -- We want to inspect that and notify whether there were any errors.

                        local textsummary = {
                            total = 0,
                            passed = 0,
                            failed = 0,
                            skipped = 0,
                        }

                        for key, value in pairs(results) do
                            textsummary.total = 1 + textsummary.total

                            if value.status == "passed" then
                                textsummary.passed = 1 + textsummary.passed
                            end

                            if value.status == "failed" then
                                textsummary.failed = 1 + textsummary.failed
                            end

                            if value.status == "skipped" then
                                textsummary.skipped = 1 + textsummary.skipped
                            end
                        end

                        if textsummary.failed == 0 and textsummary.skipped == 0 then
                            require("neotest.lib").notify(textsummary.passed .. " tests passed.")
                        elseif textsummary.failed > 0 then
                            require("neotest.lib").notify(
                                textsummary.passed .. " tests passed, with " .. textsummary.failed .. " failed.",
                                vim.log.levels.ERROR)
                        else
                            require("neotest.lib").notify(
                                textsummary.passed .. " tests passed, " .. textsummary.skipped .. " were skipped.",
                                vim.log.levels.WARN)
                        end
                    end
                    return {}
                end,
            },
            adapters = {
                require('neotest-phpunit')({
                    filter_dirs = { "vendor" },
                    root_ignore_files = { "tests/Pest.php" }
                }),
                require('neotest-rust'),
                require('neotest-pest')({
                    parallel = function() return (#vim.loop.cpu_info())/2 end,
                }),
            },
            icons = {
                expanded = "",
                child_prefix = " ",
                child_indent = " ",
                final_child_prefix = " ",
                non_collapsible = " ",
                collapsed = "",

                -- running_animated = {"⡿", "⣟", "⣯", "⣷", "⣾", "⣽", "⣻", "⢿"},
                -- running_animated = { "◐", "◓", "◑", "◒" },
                running_animated = { "󰄰", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥", "󰪥" },
                -- running_animated = { "󰸴", "󰸵", "󰸸", "󰸷" },

                passed = "",
                running = "",
                failed = "",
                unknown = ""
            },
        })

        vim.keymap.set('n', '<leader>tr', function() require('neotest').run.run("tests") end)
        vim.keymap.set('n', '<leader>tn', function() require('neotest').run.run() end)
        vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end)
        vim.keymap.set('n', '<leader>tl', function() require('neotest').run.run_last() end)
        vim.keymap.set('n', '<leader>te', function() require('neotest').run.stop() end)
        vim.keymap.set('n', '<leader>ta', function() require('neotest').run.attach() end)
        vim.keymap.set('n', '<leader>tw', function() require('neotest').run.watch() end)
        vim.keymap.set('n', '<leader>to', function() require("neotest").output.open({ enter = true }) end)
        vim.keymap.set('n', '<leader>tO', function() require('neotest').output_panel.toggle() end)
        vim.keymap.set('n', '<leader>ts', function() require('neotest').summary.toggle() end)
        vim.keymap.set('n', '<leader>tg', ":vsplit<CR>:A<CR>")
    end
}
