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
            scope = { enabled = true },
        },
        config = true,
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
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        opts = { easing = "quadratic" },
        config = true,
    },
    {
        "sphamba/smear-cursor.nvim",
        -- TODO: enable this once it gets stable. keeps craching atm.
        enabled = true,
        opts = {
            stiffness = 0.7,
            trailing_stiffness = 0.4,
            trailing_exponent = 0.1,
            distance_stop_animating = 0.1,
        },
    },
}
