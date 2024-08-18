return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "danielfalk/smart-open.nvim",
    },
    event = "VeryLazy",
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
                        ["<esc>"] = require("telescope.actions").close,
                    },
                    i = {
                        ["<C-y>"] = require("telescope.actions").select_default,
                        ["<esc>"] = require("telescope.actions").close,
                        ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
                        ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
                    },
                },
            },
        })

        require("telescope").load_extension("fzf")
        vim.keymap.set("n", "<leader><space>", function()
            require("telescope").extensions.smart_open.smart_open()
        end, { noremap = true, silent = true, desc = "Smart Search" })

        require("which-key").add({ { "<leader>s", group = "[s]earch" } })
    end,
}
