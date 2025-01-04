-- always, in every buffer, set relative line numbers
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "TabEnter" }, {
    command = "setlocal relativenumber",
})

-- Set filetype to 'env' for .env and similar files
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = { "*.env", "*.env.*" },
    callback = function()
        vim.bo.filetype = "dot"
        print("Setting filetype to dot")
    end,
})

-- After loading a buffer, if the fileencoding is not set, set it to utf-8
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "qf" then
            return
        end
        if vim.bo.fileencoding == "" then
            vim.bo.fileencoding = "utf-8"
        end
    end,
})
