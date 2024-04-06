return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
        height = 20,
        action_keys = {
            close_folds = { "zM", "zm", "<bs>" },
            open_folds = { "zR", "zr", "<cr>" },
        },
    },
    config = function(_, opts)
        require("trouble").setup(opts)

        vim.keymap.set("n", "<leader>xx", function()
            require("trouble").toggle()
        end, { desc = "Trouble Toggle" })
        vim.keymap.set("n", "<leader>xw", function()
            require("trouble").toggle("workspace_diagnostics")
        end, { desc = "Diagnosti[x] [W]orkspace" })
        vim.keymap.set("n", "<leader>xd", function()
            require("trouble").toggle("document_diagnostics")
        end, { desc = "Diagnosti[x] [D]ocument" })
        vim.keymap.set("n", "<leader>xq", function()
            require("trouble").toggle("quickfix")
        end, { desc = "Diagnosti[x] [Q]uickfix" })
        vim.keymap.set("n", "<leader>xl", function()
            require("trouble").toggle("loclist")
        end, { desc = "Diagnosti[x] [L]oclist" })

        vim.keymap.set("n", "<leader>xr", function()
            require("trouble").toggle("lsp_references")
        end, { desc = "LSP [r]eferences" })
        vim.keymap.set("n", "gr", function()
            require("trouble").toggle("lsp_references")
        end, { desc = "Trouble [r]efernces" })
    end,
}
