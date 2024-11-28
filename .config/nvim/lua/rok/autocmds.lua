-- open :help pages in vsplit on the right
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.txt",
    callback = function()
        if vim.bo.buftype == "help" then
            vim.cmd("wincmd L")
        end
    end,
})

-- always, in every buffer, set relative line numbers
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "BufWinEnter", "TabEnter" }, {
    command = "setlocal relativenumber",
})

-- Set filetype to 'env' for .env and similar files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.env", "*.env.*" },
    callback = function()
        vim.bo.filetype = "dot"
    end,
})
