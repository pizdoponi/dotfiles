local patterns = { "BufEnter */test_*.py" }

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
    init = function()
        -- create buffer local mappings for test files
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = { "*/test_*.py" },
            callback = function()
                vim.schedule(function()
                    vim.keymap.set("n", "<localleader>to", function()
                        require("neotest").output.open({ enter = true, quiet = true, auto_close = true })
                    end, { desc = "[t]est [o]utput", buffer = 0 })
                    vim.keymap.set(
                        "n",
                        "<localleader>tn",
                        require("neotest").run.run,
                        { desc = "[t]est [n]earest", buffer = 0 }
                    )
                    vim.keymap.set("n", "<localleader>tf", function()
                        require("neotest").run.run(vim.fn.expand("%"))
                    end, { desc = "[t]est [f]ile", buffer = 0 })
                    vim.keymap.set("n", "<localleader>td", function()
                        require("neotest").run.run({ strategy = "dap" })
                    end, { desc = "[t]est [d]ebug", buffer = 0 })
                end)
            end,
        })

        -- quit neotest-output buffer with q
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "neotest-output",
            command = "nnoremap <buffer> q :q<CR>",
        })
    end,
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                }),
            },
        })

        vim.keymap.set("n", "<leader>tO", require("neotest").summary.toggle, { desc = "[t]est [O]utline" })
        -- FIX: why is the mapipng below not working?
        vim.keymap.set("n", "<localleader>tl", require("neotest").run.run_last, { desc = "[t]est [l]ast" })
    end,
}
