vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "*",
    callback = function()
        local buf_ft = vim.bo.filetype
        if buf_ft == "help" or buf_ft == "man" then
            vim.api.nvim_feedkeys("gO", "n", true)
        else
            vim.keymap.set("n", "gO", "<cmd>Outline<cr>", { desc = "Open outline" })
        end
    end,
})

return {
    "hedyhli/outline.nvim",
    cmd = { "Outline" },
    opts = {
        outline_window = {
            position = "left",
            hide_cursor = false,
        },
        keymaps = {
            fold = "<left>",
            unfold = "<right>",
            fold_all = "zM",
            unfold_all = "zR",
        },
    },
}
