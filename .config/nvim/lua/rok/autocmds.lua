local group = vim.api.nvim_create_augroup("pizdoponi", { clear = false })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "TabEnter" }, {
    group = group,
    desc = "Set number and relativenumber in every buffer",
    command = "setlocal number relativenumber",
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = group,
    desc = "Set filetype to dot for .env files",
    pattern = { "*.env", "*.env.*" },
    callback = function()
        vim.bo.filetype = "dot"
        vim.notify("Setting filetype to dot", vim.log.levels.INFO)
    end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = group,
    desc = "Set fileencoding to utf-8 if not set",
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
