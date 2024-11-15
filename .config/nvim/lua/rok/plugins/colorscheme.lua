return {
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = {
            style = "night",
        },
        config = function()
            require("tokyonight").setup({
                style = "night",
            })
            vim.cmd([[colorscheme tokyonight]])
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({})
            vim.cmd("colorscheme catppuccin")
        end,
    },
}
