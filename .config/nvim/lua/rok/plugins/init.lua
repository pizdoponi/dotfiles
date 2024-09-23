return {
    "tpope/vim-unimpaired",
    "tpope/vim-repeat",
    { "tpope/vim-abolish" },
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        opts = { easing = "quadratic" },
        config = true,
    },
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
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        config = true,
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
        "lukas-reineke/indent-blankline.nvim",
        lazy = true,
        event = "InsertEnter",
        main = "ibl",
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
            { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
        },
        opts = { use_default_keymaps = false, max_join_length = 150 },
    },
}
