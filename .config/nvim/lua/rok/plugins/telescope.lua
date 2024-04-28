return {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        event = "VeryLazy",
        keys = {
            { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Search Files" },
            { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
            { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "[S]earch [B]uffers" },
            { "<leader>sr", "<cmd>Telescope lsp_references<cr>", desc = "[S]earch [R]eferences" },
            { "<leader>so", "<cmd>Telescope oldfiles<cr>", desc = "[S]earch [O]ldfiles" },
            {
                "<leader>sw",
                "<cmd>Telescope grep_string<cr>",
                desc = "[S]earch for a [W]ord under cursor",
            },
            { "<leader>s/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[S]earch fuzzy in current file" },
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
                },

                defaults = {
                    mappings = {
                        n = {
                            ["q"] = require("telescope.actions").close,
                            ["<esc>"] = require("telescope.actions").close,
                        },
                        i = {
                            ["<C-y>"] = require("telescope.actions").select_default,
                            ["<esc>"] = require("telescope.actions").close,
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                            ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
                            ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
                        },
                    },
                },
            })

            require("telescope").load_extension("fzf")
        end,
    }
