vim.keymap.set("n", "<localleader>rr", function()
    vim.cmd("REPLStart racket")
end, { desc = "Start racket REPL" })

vim.schedule(function()
    local tbl = vim.lsp.get_clients({ bufnr = 0 })
    local tbl_is_empty = next(tbl) == nil

    if tbl_is_empty then
        require("lspconfig")
        vim.notify("Starting racket_langserver")
        vim.defer_fn(function()
            vim.cmd("LspStart racket_langserver")
        end, 100)
    end
end)
