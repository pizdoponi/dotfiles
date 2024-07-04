-- return {
--     "folke/trouble.nvim",
--     dependencies = { "nvim-tree/nvim-web-devicons" },
--     event = "VeryLazy",
--     opts = {
--         height = 20,
--         action_keys = {
--             close_folds = { "zM", "zm", "<bs>" },
--             open_folds = { "zR", "zr", "<cr>" },
--         },
--     },
--     config = function(_, opts)
--         require("trouble").setup(opts)
--
--         vim.keymap.set("n", "<leader>xx", function()
--             require("trouble").toggle()
--         end, { desc = "Trouble Toggle" })
--         vim.keymap.set("n", "<leader>xw", function()
--             require("trouble").toggle("workspace_diagnostics")
--         end, { desc = "Diagnosti[x] [W]orkspace" })
--         vim.keymap.set("n", "<leader>xd", function()
--             require("trouble").toggle("document_diagnostics")
--         end, { desc = "Diagnosti[x] [D]ocument" })
--         vim.keymap.set("n", "<leader>xq", function()
--             require("trouble").toggle("quickfix")
--         end, { desc = "Diagnosti[x] [Q]uickfix" })
--         vim.keymap.set("n", "<leader>xl", function()
--             require("trouble").toggle("loclist")
--         end, { desc = "Diagnosti[x] [L]oclist" })
--
--         vim.keymap.set("n", "<leader>xr", function()
--             require("trouble").toggle("lsp_references")
--         end, { desc = "LSP [r]eferences" })
--         vim.keymap.set("n", "gr", function()
--             require("trouble").toggle("lsp_references")
--         end, { desc = "Trouble [r]efernces" })
--     end,
-- }
--
return {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {

        height = 20,
        action_keys = {
            close_folds = { "zM", "zm", "<bs>" },
            open_folds = { "zR", "zr", "<cr>" },
        },
    },

    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
        { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
        {
            "<leader>cS",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP references/definitions/... (Trouble)",
        },
        { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
        { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
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
            desc = "Previous Trouble/Quickfix Item",
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
            desc = "Next Trouble/Quickfix Item",
        },
    },
}
