vim.keymap.set("n", "<localleader>rr", function()
    local count = vim.v.count1
    vim.cmd(count .. "REPLStart ipython")
    vim.cmd("wincmd w")
end, { desc = "Start ipython REPL" })

vim.schedule(function()
    local tbl = vim.lsp.get_clients({ bufnr = 0 })
    local tbl_is_empty = next(tbl) == nil

    if tbl_is_empty then
        require("lspconfig")
        vim.notify("Starting basedpyright and ruff")
        vim.defer_fn(function()
            vim.cmd("LspStart basedpyright ruff")
        end, 100)
    end
end)
