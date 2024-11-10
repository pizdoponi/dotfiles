return {
    "tpope/vim-unimpaired",
    "tpope/vim-repeat",
    "tpope/vim-abolish",
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
        "nvim-pack/nvim-spectre",
        cmd = "Spectre",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
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
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        enabled = false,
        event = "VeryLazy",
        config = function()
            require("lsp_lines").setup()
            -- Disable virtual_text since it's redundant due to lsp_lines.
            vim.diagnostic.config({
                virtual_text = false,
            })

            vim.keymap.set("n", "=sd", function()
                vim.diagnostic.config({
                    virtual_text = true,
                    virtual_lines = false,
                })
            end, { desc = "Toggle lsp_lines" })
        end,
    },
}
