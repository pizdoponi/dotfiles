return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        keys = {
            { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "[b]reakpoint toggle" },
        },
        dependencies = {
            { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
            "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap-python",
            "leoluz/nvim-dap-go",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
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

            require("dap-go").setup()

            require("which-key").add({ { "<leader>d", group = "[d]ebug" } })
        end,
    },
}
