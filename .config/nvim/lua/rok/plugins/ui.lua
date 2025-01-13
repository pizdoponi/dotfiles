return {
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "jinh0/eyeliner.nvim",
        event = "VeryLazy",
        config = function()
            require("eyeliner").setup({
                higlight_on_key = true,
                dim = true,
            })

            local color = "#ffdf00" -- golden yellow
            vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = color, bold = true })
            vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = color })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = "ibl",
        opts = {
            scope = { enabled = false },
        },
    },
    {
        "shellRaining/hlchunk.nvim",
        event = "VeryLazy",
        opts = {
            chunk = {
                enable = true,
                delay = 100,
                duration = 100,
                style = { "#a6e3a1", "#f38ba8" },
            },
        },
        config = true,
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        opts = {
            "*", -- attach to all filetypes
        },
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        -- VeryLazy or lazy loading does not work; the first opened buffer will not have rainbow delimiters
    },
}
