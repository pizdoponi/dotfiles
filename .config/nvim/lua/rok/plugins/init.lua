return {
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "tpope/vim-repeat",

    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            map_cr = false,
        },
    },
    {
        "GCBallesteros/jupytext.nvim",
        config = true,
        lazy = false,
    },
}
