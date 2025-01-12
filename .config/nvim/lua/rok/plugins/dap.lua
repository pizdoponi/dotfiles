return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
            "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap-python",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup({
                controls = { enabled = false },
                mappings = {
                    expand = { "<CR>", "<Tab>" },
                },
            })

            require("nvim-dap-virtual-text").setup({})

            -- dap.listeners.before.attach.dapui_config = function()
            --     dapui.open()
            -- end
            -- dap.listeners.before.launch.dapui_config = function()
            --     dapui.open()
            -- end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            require("dap-python").setup("python")
            require("dap-python").test_runner = "pytest"

            vim.keymap.set("n", "<F12>", dap.continue)
            vim.keymap.set("n", "<F15>", dap.step_over)
            vim.keymap.set("n", "<F16>", dap.step_into)
            vim.keymap.set("n", "<F14>", dap.step_out)
            vim.keymap.set("n", "<F18>", dap.step_back)

            vim.keymap.set("n", "<leader>d?", function()
                dapui.eval(nil, { enter = true })
            end, { desc = "inspect object under cursor" })
            vim.keymap.set("v", "<leader>de", function()
                dapui.eval(nil, { enter = true })
            end, { desc = "[e]val visual selection" })

            -- vim.keymap.set("n", "<leader>dlb", function()
            --     dapui.float_element("breakpoints", { enter = true, position = "center" })
            -- end, { desc = "[l]ist [b]reakpoints" })

            -- ── :DapEval enhancements ───────────────────────────────────────────
            local is_dap_eval_open = false
            vim.keymap.set("n", "<leader>de", function()
                local function close_dap_eval_buffer()
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        local buf_name = vim.api.nvim_buf_get_name(buf)
                        if buf_name:match("^dap%-eval://") then
                            vim.api.nvim_buf_delete(buf, { force = true })
                        end
                    end
                end

                if is_dap_eval_open then
                    -- close dap eval
                    dap.repl.close()
                    close_dap_eval_buffer()
                else
                    -- open dap eval
                    -- and close dapui, if open
                    pcall(dapui.close)
                    vim.cmd("DapEval")
                    vim.cmd("wincmd L")
                    dap.repl.open()
                end

                is_dap_eval_open = not is_dap_eval_open
            end, { desc = "[e]val" })
            -- ──────────────────────────────────────────────────────────────────────

            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "toggle [b]reakpoint" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "toggle conditional [B]reakpoint" })

            vim.keymap.set("n", "<leader>do", function()
                dapui.toggle()
            end, { desc = "[o]pen (or close) dapui" })

            vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "ErrorMsg", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "ErrorMsg", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "", texthl = "IncSearch", linehl = "", numhl = "IncSearch" })
        end,
    },
    {
        "Goose97/timber.nvim",
        lazy = true,
        opts = {
            defualt_keymaps_enabled = false,
            log_templates = {
                default = {
                    python = [[print('[LOGZILLA]::%filename::%line_number::%log_target', %log_target)]],
                },
                plain = {
                    python = [[print('[LOGZILLA]::%filename::%line_number %insert_cursor')]],
                },
            },
            keymaps = {
                insert_log_below = "<leader>p<down>",
                insert_log_above = "<leader>p<up>",
                insert_plain_log_below = "<leader>po",
                insert_plain_log_above = "<leader>p<S-o>",
                insert_batch_log = "<leader>pb",
                add_log_targets_to_batch = "<leader>pa",
                insert_log_below_operator = "<leader>p<S-l><down>",
                insert_log_above_operator = "<leader>p<S-l><up>",
                insert_batch_log_operator = "<leader>p<S-l>b",
                add_log_targets_to_batch_operator = "<leader>p<S-l>a",
            },
        },
        config = true,
    },
}
