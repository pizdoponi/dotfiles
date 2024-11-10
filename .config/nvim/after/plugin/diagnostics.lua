-- set diagnostic signs
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰈸",
            [vim.diagnostic.severity.WARN] = "󱐋",
            [vim.diagnostic.severity.HINT] = "󰌵",
            [vim.diagnostic.severity.INFO] = "",
        },
        linehl = {
            -- [vim.diagnostic.severity.ERROR] = "ErrorMsg",
        },
        numhl = {
            -- [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})
