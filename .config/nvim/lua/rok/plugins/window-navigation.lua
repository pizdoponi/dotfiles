return {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    config = function()
        require("smart-splits").setup()
        -- these keymaps will also accept a range,
        -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
        vim.keymap.set("n", "<S-A-left>", require("smart-splits").resize_left)
        vim.keymap.set("n", "<S-A-down>", require("smart-splits").resize_down)
        vim.keymap.set("n", "<S-A-up>", require("smart-splits").resize_up)
        vim.keymap.set("n", "<S-A-right>", require("smart-splits").resize_right)
        -- moving between splits
        vim.keymap.set({ "n", "i", "v", "t" }, "<A-left>", require("smart-splits").move_cursor_left)
        vim.keymap.set({ "n", "i", "v", "t" }, "<A-down>", require("smart-splits").move_cursor_down)
        vim.keymap.set({ "n", "i", "v", "t" }, "<A-up>", require("smart-splits").move_cursor_up)
        vim.keymap.set({ "n", "i", "v", "t" }, "<A-right>", require("smart-splits").move_cursor_right)
        -- swapping buffers between windows
        vim.keymap.set("n", "<leader>w<left>", require("smart-splits").swap_buf_left, { desc = "move [w]indow left" })
        vim.keymap.set("n", "<leader>w<down>", require("smart-splits").swap_buf_down, { desc = "move [w]indow down" })
        vim.keymap.set("n", "<leader>w<up>", require("smart-splits").swap_buf_up, { desc = "move [w]indow up" })
        vim.keymap.set(
            "n",
            "<leader>w<right>",
            require("smart-splits").swap_buf_right,
            { desc = "move [w]indow right" }
        )
    end,
}
