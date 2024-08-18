return {
    "klen/nvim-test",
    keys = {
        { "<leader>rtf", "<cmd>TestFile<cr>", desc = "[r]un [t]est [f]ile" },
        { "<leader>rtn", "<cmd>TestNearest<cr>", desc = "[r]un [t]est [n]earest" },
        { "<leader>rts", "<cmd>TestSuite<cr>", desc = "[r]un [t]est [s]uite" },
        { "<leader>rtl", "<cmd>TestLast<cr>", desc = "[r]un [t]est [l]ast" },
    },
    config = function()
        require("nvim-test").setup({
            silent = true,
            term = "toggleterm",
            termOpts = {
                direction = "vertical",
                go_back = false,
                -- width = 80,
            },
        })
    end,
}
