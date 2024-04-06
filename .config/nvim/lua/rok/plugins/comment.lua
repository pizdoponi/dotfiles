return {
    {
        "numToStr/Comment.nvim",
        opts = {
            padding = true,
            sticky = true,
            ignore = "^$",
        },
        lazy = true,
        event = "BufEnter",
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim", "nvim-telescope/telescope.nvim" },
        event = "VeryLazy",
        opts = {
            keywords = {
                NOTE = { icon = "󰎚 ", color = "hint", alt = { "INFO" } },
            },
        },
        config = function(_, opts)
            require("todo-comments").setup(opts)

            vim.keymap.set("n", "]t", function()
                require("todo-comments").jump_next()
            end, { desc = "Next [T]odo comment" })

            vim.keymap.set("n", "[t", function()
                require("todo-comments").jump_prev()
            end, { desc = "Previous [T]odo comment" })

            vim.keymap.set("n", "<leader>xc", "<md>TodoTrouble<cr>", { desc = "Diagnosti[x] [C]omments" })
            vim.keymap.set("n", "<leader>sc", "<cmd>TodoTelescope<cr>", { desc = "[S]earch [C]omments" })
        end,
    },
}
