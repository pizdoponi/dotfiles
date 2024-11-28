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
        { "<leader>ll", "<cmd>Trouble<cr>", desc = ":Trouble" },
        { "<leader>ld", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", desc = "[l]ist [d]iagnostics" },
        { "<leader>lD", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "[l]ist workspace [D]iagnostics" },
        { "<leader>ls", "<cmd>Trouble symbols toggle focus=false win.position=left<cr>", desc = "[l]ist [s]ymbols" },
        { "<leader>lq", "<cmd>Trouble qflist toggle focus=true<cr>", desc = "[l]ist [q]uickfix" },
        { "<leader>lc", "<cmd>Trouble todo toggle focus=true<cr>", desc = "[l]ist [c]omments" },
    },
    config = function(_, opts)
        require("trouble").setup(opts)

        require("which-key").add({ { "<leader>l", group = "[l]og" } })
    end,
}
