return {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
        height = 30,
        action_keys = {
            close_folds = { "zM", "zm", "<bs>" },
            open_folds = { "zR", "zr", "<cr>" },
        },
    },

    keys = {
        { "<leader>ld", "<cmd>Trouble diagnostics toggle<cr>", desc = "[l]ist [d]iagnostics" },
        { "<leader>lD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[l]ist buffer [d]iagnostics" },
        { "<leader>ls", "<cmd>Trouble symbols toggle focus=false win.position=left<cr>", desc = "[l]ist [s]ymbols" },
        {
            "<leader>lS",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP references/definitions/... (Trouble)",
        },
        { "<leader>ll", "<cmd>Trouble loclist toggle<cr>", desc = "[l]ist [l]oclist" },
        { "<leader>lq", "<cmd>Trouble qflist toggle<cr>", desc = "[l]ist [q]flist" },
        {
            "[q",
            function()
                if require("trouble").is_open() then
                    require("trouble").prev({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Previous Quickfix Item",
        },
        {
            "]q",
            function()
                if require("trouble").is_open() then
                    require("trouble").next({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cnext)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Next Quickfix Item",
        },
    },
}
