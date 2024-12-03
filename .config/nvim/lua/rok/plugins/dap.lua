return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
            "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap-python",
            -- "leoluz/nvim-dap-go",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup({
                controls = { enabled = false },
                mappings = {
                    expand = { "<CR>", "<Tab>" },
                },
                layouts = {
                    {
                        elements = {
                            {
                                id = "stacks",
                                size = 0.20,
                            },
                            {
                                id = "scopes",
                                size = 0.30,
                            },
                            {
                                id = "watches",
                                size = 0.50,
                            },
                        },
                        position = "left",
                        size = 40,
                    },
                },
            })

            require("nvim-dap-virtual-text").setup()

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

            require("dap-python").setup("python")
            require("dap-python").test_runner = "pytest"

            -- require("dap-go").setup()

            require("which-key").add({ { "<leader>d", group = "[d]ebug" } })

            vim.keymap.set("n", "<F5>", dap.continue)
            vim.keymap.set("n", "<F4>", dap.step_over)
            vim.keymap.set("n", "<F6>", dap.step_into)
            vim.keymap.set("n", "<F11>", dap.step_out)

            vim.keymap.set("n", "<leader>di", function()
                dapui.eval(nil, { enter = true })
            end, { desc = "[i]nspect object under cursor" })
            vim.keymap.set("v", "<leader>de", function()
                dapui.eval(nil, { enter = true })
            end, { desc = "[e]val visual selection" })

            vim.keymap.set("n", "<leader>dlb", function()
                dapui.float_element("breakpoints", { enter = true, position = "center" })
            end, { desc = "[l]ist [b]reakpoints" })

            vim.keymap.set("n", "<leader>de", function()
                vim.cmd("DapEval")
                dap.repl.open()
                vim.cmd("wincmd k")
                vim.cmd("wincmd H")
                vim.cmd("wincmd l")
            end, { desc = "[e]val" })

            vim.keymap.set("n", "<leader>da", dap.restart, { desc = "restart debug session [a]gain" })
            vim.keymap.set("n", "<leader>dh", dap.terminate, { desc = "[h]alt debug session" })
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "toggle [b]reakpoint" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "toggle conditional [B]reakpoint" })

            vim.keymap.set("n", "<leader>do", function()
                dapui.toggle()
            end, { desc = "[o]pen (or close) dapui" })

            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "ErrorMsg" })
            vim.fn.sign_define("DapStopped", { text = "", texthl = "IncSearch", linehl = "", numhl = "IncSearch" })
        end,
    },
}
