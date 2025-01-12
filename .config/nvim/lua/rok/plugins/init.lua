return {
    "tpope/vim-repeat",
    "tpope/vim-abolish",
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            map_cr = true,
        },
    },
    {
        "GCBallesteros/jupytext.nvim",
        config = true,
        lazy = false,
    },
    {
        "nvim-pack/nvim-spectre",
        cmd = "Spectre",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = true,
    },
    {
        "MagicDuck/grug-far.nvim",
        cmd = "GrugFar",
        config = true,
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {
            move_cursor = true,
        },
    },
    {
        "Wansmer/treesj",
        keys = {
            { "<A-j>", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
        },
        opts = { use_default_keymaps = false, max_join_length = 150 },
    },
    {
        "marcussimonsen/let-it-snow.nvim",
        cmd = "LetItSnow", -- Wait with loading until command is run
        opts = {},
    },
    {
        "rgroli/other.nvim",
        keys = {
            { "go", "<cmd>Other<cr>", desc = "Go to Other file" },
        },
        config = function()
            require("other-nvim").setup({
                mappings = {
                    "python",
                },
            })
        end,
    },
}
