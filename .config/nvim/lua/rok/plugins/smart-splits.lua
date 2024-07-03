return {
    "mrjones2014/smart-splits.nvim",
    config = function()
        require("smart-splits").setup()
        -- recommended mappings
        -- resizing splits
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
        vim.keymap.set({ "n", "i", "v", "t" }, "<A-space>", require("smart-splits").move_cursor_previous)
        -- swapping buffers between windows
        -- vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
        -- vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
        -- vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
        -- vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
    end,
}
