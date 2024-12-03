return {
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "j-hui/fidget.nvim",
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
                -- style = { "#89b4fa", "#f38ba8" },
                -- style = { "#00ffff", "#f38ba8" },
                style = { "#ffdf00", "#f38ba8" },
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
}
