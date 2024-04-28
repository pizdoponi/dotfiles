return {
    "klen/nvim-test",
    keys = {
        { "<leader>rtf", "<cmd>TestFile<cr>", desc = "test file" },
        { "<leader>rtn", "<cmd>TestNearest<cr>", desc = "test nearest" },
        { "<leader>rts", "<cmd>TestSuite<cr>", desc = "test suite" },
        { "<leader>rtl", "<cmd>TestLast<cr>", desc = "test last" },
    },
    opts = {},
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
