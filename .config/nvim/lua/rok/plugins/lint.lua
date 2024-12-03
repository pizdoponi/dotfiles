return {
    "mfussenegger/nvim-lint",
    lazy = true,
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            python = { "pylint", "pydocstyle" },
            lua = { "selene" },
            typescript = { "eslint_d" },
            javascript = { "eslint_d" },
        }
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
