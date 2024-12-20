return {
    "mrjones2014/smart-splits.nvim",
    -- TODO: integrate with wezterm
    config = function()
        require("smart-splits").setup({
            default_amount = 5,
        })
        -- these keymaps will also accept a range,
        -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
        vim.keymap.set("n", "<A-left>", require("smart-splits").resize_left)
        vim.keymap.set("n", "<A-down>", require("smart-splits").resize_down)
        vim.keymap.set("n", "<A-up>", require("smart-splits").resize_up)
        vim.keymap.set("n", "<A-right>", require("smart-splits").resize_right)
        -- moving between splits
        vim.keymap.set({ "n", "i", "v", "t" }, "<C-left>", require("smart-splits").move_cursor_left)
        vim.keymap.set({ "n", "i", "v", "t" }, "<C-down>", require("smart-splits").move_cursor_down)
        vim.keymap.set({ "n", "i", "v", "t" }, "<C-up>", require("smart-splits").move_cursor_up)
        vim.keymap.set({ "n", "i", "v", "t" }, "<C-right>", require("smart-splits").move_cursor_right)
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
