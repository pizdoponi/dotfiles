return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        config = function()
            local configs = require("nvim-treesitter.configs")
            ---@diagnostic disable-next-line: missing-fields
            configs.setup({
                ensure_installed = {
                    "bash",
                    "comment",
                    "css",
                    "csv",
                    "diff",
                    "dockerfile",
                    "git_config",
                    "git_rebase",
                    "gitcommit",
                    "gitignore",
                    "html",
                    "http",
                    "javascript",
                    "jsdoc",
                    "json",
                    "lua",
                    "luadoc",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "regex",
                    "sql",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "xml",
                    "yaml",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>v",
                        scope_incremental = false,
                        node_incremental = "<tab>",
                        node_decremental = "<bs>",
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["al"] = { query = "@loop.outer", desc = "outer loop" },
                            ["il"] = { query = "@loop.inner", desc = "inner loop" },

                            ["af"] = { query = "@function.outer", desc = "outer function" },
                            ["if"] = { query = "@function.inner", desc = "inner function" },

                            ["ar"] = { query = "@class.outer", desc = "outer class" },
                            ["ir"] = { query = "@class.inner", desc = "inner class" },
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>;a"] = { query = "@parameter.inner", desc = "swap with the next argument" }, -- swap parameters/argument with next
                            ["<leader>;p"] = { query = "@property.outer", desc = "swap with the next property" }, -- swap object property with next
                            ["<leader>;f"] = { query = "@function.outer", desc = "swap with the next function" }, -- swap function with next
                        },
                        swap_previous = {
                            ["<leader>,a"] = { query = "@parameter.inner", desc = "swap with the prev argument" }, -- swap parameters/argument with prev
                            ["<leader>,p"] = { query = "@property.outer", desc = "swap with the prev property" }, -- swap object property with prev
                            ["<leader>,f"] = { query = "@function.outer", desc = "swap with the prev function" }, -- swap function with previous
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]f"] = { query = "@function.outer", desc = "Next function start" },
                            ["]r"] = { query = "@class.outer", desc = "Next class end" },
                            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                        },
                        goto_next_end = {
                            ["]F"] = { query = "@function.outer", desc = "Next function end" },
                            ["]R"] = { query = "@class.outer", desc = "Next class end" },
                            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                        },
                        goto_previous_start = {
                            ["[f"] = { query = "@function.outer", desc = "Prev function start" },
                            ["[r"] = { query = "@class.outer", desc = "Prev class start" },
                            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
                        },
                        goto_previous_end = {
                            ["[F"] = { query = "@function.outer", desc = "Prev function end" },
                            ["[R"] = { query = "@class.outer", desc = "Prev class end" },
                            ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
                        },
                    },
                },
            })

            local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

            -- vim way: ; goes to the direction you were moving.
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

            -- Register which-key mappings
            pcall(function()
                require("which-key").add({
                    { "<leader>;", group = "Swap next" },
                    { "<leader>,", group = "Swap prev" },
                })
            end)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "chrisgrieser/nvim-various-textobjs",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = { useDefaultKeymaps = true },
    },
}
