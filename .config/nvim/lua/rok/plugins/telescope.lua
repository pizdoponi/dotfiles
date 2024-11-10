return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[s]earch [f]iles" },
            { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "workspace /" },
            { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "[s]earch [b]uffers" },
            { "<leader>sr", "<cmd>Telescope lsp_references<cr>", desc = "[s]earch [r]eferences" },
            { "<leader>so", "<cmd>Telescope oldfiles<cr>", desc = "[s]earch [o]ldfiles" },
            { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[s]earch [h]elp_tags" },
            {
                "<leader>sw",
                "<cmd>Telescope grep_string<cr>",
                desc = "[s]earch for [w]ord under cursor",
            },
            { "<leader>s/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[s]earch fuzzy in current file" },
            { "<leader>:", "<cmd>Telescope commands<cr>", desc = "cmd" },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    },
                    smart_open = {
                        match_algorithm = "fzf",
                        disable_devicons = false,
                    },
                },

                defaults = {
                    mappings = {
                        n = {
                            ["q"] = require("telescope.actions").close,
                        },
                        i = {
                            ["<C-y>"] = require("telescope.actions").select_default,
                            ["<C-q>"] = require("telescope.actions").smart_send_to_qflist,
                        },
                    },
                },
            })

            require("telescope").load_extension("fzf")
            require("which-key").add({ { "<leader>s", group = "[s]earch" } })
        end,
    },
    {
        "danielfalk/smart-open.nvim",
        lazy = true,
        branch = "0.2.x",
        keys = {
            {
                "<leader><space>",
                function()
                    require("telescope").extensions.smart_open.smart_open()
                end,
                desc = "Smart Search",
            },
        },
        config = function()
            require("telescope").load_extension("smart_open")
        end,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "kkharji/sqlite.lua",
        },
    },
}