return {
    {
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
            { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[S]earch [F]iles" },
            { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "[S]earch [B]uffers" },
            { "<leader>sR", "<cmd>Telescope lsp_references<cr>", desc = "[S]earch [R]eferences" },
            { "<leader>so", "<cmd>Telescope oldfiles<cr>", desc = "[S]earch [O]ldfiles" },
            {
                "<leader>sw",
                "<cmd>Telescope grep_string<cr>",
                desc = "[S]earch for a [W]ord under cursor",
            },
            { "<leader>s/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[S]earch fuzzy in current file" },
        },
        config = function()
            -- You dont need to set any of these options. These are the default ones. Only
            -- the loading is important
            require("telescope").setup({
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
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
            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "ThePrimeagen/harpoon",
        enabled = true,
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup({})
            vim.keymap.set("n", "<leader>ba", function()
                harpoon:list():append()
            end, { desc = "[a]dd to harpoon" })
            vim.keymap.set("n", "<leader>bh", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = "[h]arpoon" })

            vim.keymap.set("n", "<C-0>", function()
                harpoon:list():select(1)
            end, { desc = "[G]oto 1st harpoon buffer" })
            vim.keymap.set("n", "<C-4>", function()
                harpoon:list():select(2)
            end, { desc = "[G]oto 2nd harpoon buffer" })
            vim.keymap.set("n", "<C-5>", function()
                harpoon:list():select(3)
            end, { desc = "[G]oto 3rd harpoon buffer" })
            vim.keymap.set("n", "<C-6>", function()
                harpoon:list():select(4)
            end, { desc = "[G]oto 4th harpoon buffer" })

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<S-left>", function()
                harpoon:list():prev()
            end)
            vim.keymap.set("n", "<S-right>", function()
                harpoon:list():next()
            end)
        end,
    },
    {
        "stevearc/oil.nvim",
        lazy = false,
        keys = {
            { "<leader>o", "<cmd>Oil<cr>", desc = "coconut oil" },
        },
        opts = {
            keymaps = {

                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<BS>"] = "actions.parent",
                ["<Tab>"] = "actions.preview",
                ["<leader>o"] = "actions.close",
                ["<C-d>"] = "actions.preview_scroll_down",
                ["<C-u>"] = "actions.preview_scroll_up",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
            },
            use_default_keymaps = false,
            lsp_file_methods = {
                timeout_ms = 3000,
                autosave_changes = true,
            },
            view_options = {
                show_hidden = false,
            },
            experimental_watch_for_changes = true,
            skip_confirm_for_simple_edits = true,
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
    },
    {
        "mrjones2014/smart-splits.nvim",
        lazy = false,
        config = function()
            require("smart-splits").setup({})

            vim.keymap.set("n", "<S-A-left>", require("smart-splits").resize_left)
            vim.keymap.set("n", "<S-A-down>", require("smart-splits").resize_down)
            vim.keymap.set("n", "<S-A-up>", require("smart-splits").resize_up)
            vim.keymap.set("n", "<S-A-right>", require("smart-splits").resize_right)
            -- moving between splits
            vim.keymap.set("n", "<A-left>", require("smart-splits").move_cursor_left)
            vim.keymap.set("n", "<A-down>", require("smart-splits").move_cursor_down)
            vim.keymap.set("n", "<A-up>", require("smart-splits").move_cursor_up)
            vim.keymap.set("n", "<A-right>", require("smart-splits").move_cursor_right)
            vim.keymap.set("n", "<A-\\>", require("smart-splits").move_cursor_previous)
        end,
    },
}
