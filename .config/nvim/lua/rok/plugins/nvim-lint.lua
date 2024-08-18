return {
    "mfussenegger/nvim-lint",
    keys = {
        {
            "<leader>bl",
            function()
                require("lint").try_lint()
            end,
            desc = "[b]uffer [l]int",
        },
    },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            python = { "pylint" },
            typescript = { "eslint_d" },
            javascript = { "eslint_d" },
            svelte = { "eslint_d" },
        }
        -- NOTE: linting has to first be manually triggered with <leader>bl
        -- after that, linting will be triggered on BufEnter, BufWritePost, and InsertLeave
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
