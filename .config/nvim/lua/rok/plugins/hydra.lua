return {
    "anuvyklack/hydra.nvim",
    event = "VeryLazy",
    config = function()
        local Hydra = require("hydra")

        Hydra({
            name = "wincmd",
            mode = "n",
            body = "<C-w>",
            heads = {
                { ">", "<C-w>>", { desc = "Increase Width" } },
                { "<", "<C-w><", { desc = "Decrease Width" } },
                { "+", "<C-w>+", { desc = "Increase Height" } },
                { "-", "<C-w>-", { desc = "Decrease Height" } },
            },
        })

        Hydra({
            name = "Treewalker",
            mode = "n",
            body = "<leader>W",
            heads = {
                { "<down>", "<cmd>Treewalker Down<cr>", { desc = "Move Down" } },
                { "<up>", "<cmd>Treewalker Up<cr>", { desc = "Move Up" } },
                { "<left>", "<cmd>Treewalker Left<cr>", { desc = "Move Left" } },
                { "<right>", "<cmd>Treewalker Right<cr>", { desc = "Move Right" } },
            },
        })
    end,
}
