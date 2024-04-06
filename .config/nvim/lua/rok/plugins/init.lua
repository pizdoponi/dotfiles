return {
    "tpope/vim-repeat",
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "undotree" },
        },
        config = function()
            vim.g.undotree_SplitWidth = 40
            vim.g.undotree_DiffpanelHeight = 12
            vim.g.undotree_DiffAutoOpen = 1
            vim.g.undotree_SetFocusWhenToggle = 1
        end,
    },
    {
        "nvim-pack/nvim-spectre",
        keys = {
            { "<leader>R", "<cmd>Spectre<cr>", desc = "Spectre" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = true,
    },
    {
        "folke/zen-mode.nvim",
        dependencies = {
            "folke/twilight.nvim",
        },
        keys = {
            { "<leader>z", "<cmd>ZenMode<cr>", desc = "zen mode" },
        },
        opts = {
            plugins = {
                tmux = { enabled = true },
                gitsigns = { enabled = true },
            },
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            map_cr = false,
        },
    },
    {
        "jinh0/eyeliner.nvim",
        -- event = "VeryLazy",
        config = function()
            require("eyeliner").setup({
                higlight_on_key = true,
                dim = true,
            })
            -- local color = "#00bfff" -- sky blue
            local color = "#ffdf00" -- golden yellow
            vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = color, bold = true })
            vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = color })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = true,
        event = "BufEnter",
        main = "ibl",
        opts = {},
        config = true,
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                move_cursor = false,
            })
        end,
    },
    {
        "GCBallesteros/jupytext.nvim",
        config = true,
        -- event = "VeryLazy"
        lazy = false,
    }
}
