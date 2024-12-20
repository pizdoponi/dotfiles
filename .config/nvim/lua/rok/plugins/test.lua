return {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
    },
    event = { "BufEnter */test_*.py" },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                }),
            },
        })

        vim.keymap.set("n", "<leader>tO", require("neotest").summary.toggle, { desc = "[t]est [O]utline" })
        vim.keymap.set("n", "<leader>to", function()
            require("neotest").output.open({ enter = true, quiet = true, auto_close = true })
        end, { desc = "[t]est [o]utput" })
        vim.keymap.set("n", "<leader>tn", require("neotest").run.run, { desc = "[t]est [n]earest" })
        vim.keymap.set("n", "<leader>tl", require("neotest").run.run_last, { desc = "[t]est [l]ast" })
        vim.keymap.set("n", "<leader>tf", function()
            require("neotest").run.run(vim.fn.expand("%"))
        end, { desc = "[t]est [f]ile" })
        vim.keymap.set("n", "<leader>td", function()
            require("neotest").run.run({ strategy = "dap" })
        end, { desc = "[t]est [d]ebug" })
    end,
}
