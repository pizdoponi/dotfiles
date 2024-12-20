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
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        lazy = true,
        config = function()
            require("lsp_lines").setup()
            -- Disable virtual_text since it's redundant due to lsp_lines.
            vim.diagnostic.config({
                virtual_text = false,
                virtual_lines = true,
            })
        end,
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        -- event = "VeryLazy", -- Or `LspAttach`
        enabled = true,
        priority = 900, -- needs to be loaded in first
        config = function()
            -- remove virtual text
            vim.diagnostic.config({ virtual_text = false, severity_sort = true })
            require("tiny-inline-diagnostic").setup({
                preset = "classic",
                options = {
                    show_source = false,
                    multilines = false,
                },
                hi = {
                    background = "Normal",
                },
            })
        end,
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
