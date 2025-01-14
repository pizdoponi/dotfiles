return {
    {
        "MeanderingProgrammer/markdown.nvim",
        ft = "markdown",
        name = "render-markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {},
    },
    {
        "toppair/peek.nvim",
        ft = "markdown",
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup()
            vim.api.nvim_buf_create_user_command(0, "PeekOpen", require("peek").open, {})
            vim.api.nvim_buf_create_user_command(0, "PeekClose", require("peek").close, {})
            vim.keymap.set("n", "<localleader>p", "<cmd>PeekOpen<cr>", { desc = "[p]review markdown", buffer = 0 })
        end,
    },
}
