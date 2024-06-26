return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    config = function()
        require("nvim-treesitter.configs").setup({
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                        ["l="] = { query = "@assignment.lhs", desc = "Select [L]hs of an assignment" },
                        ["=r"] = { query = "@assignment.rhs", desc = "Select [R]hs of an assignment" },

                        ["aa"] = { query = "@parameter.outer", desc = "Select outer part of an [A]rgument" },
                        ["ia"] = { query = "@parameter.inner", desc = "Select inner part of an [A]rgument" },

                        ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a [I]f" },
                        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a [I]f" },

                        ["al"] = { query = "@loop.outer", desc = "Select outer part of a [L]oop" },
                        ["il"] = { query = "@loop.inner", desc = "Select inner part of a [L]oop" },

                        ["ak"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                        ["ik"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                        ["af"] = { query = "@function.outer", desc = "Select outer part of a [F]unction" },
                        ["if"] = { query = "@function.inner", desc = "Select inner part of a [F]unction" },

                        ["ac"] = { query = "@class.outer", desc = "Select outer part of a [C]lass" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a [C]lass" },
                    },
                },
                -- swap = {
                --   enable = true,
                --   swap_next = {
                --     ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
                --     ["<leader>n:"] = "@property.outer", -- swap object property with next
                --     ["<leader>nm"] = "@function.outer", -- swap function with next
                --   },
                --   swap_previous = {
                --     ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
                --     ["<leader>p:"] = "@property.outer", -- swap object property with prev
                --     ["<leader>pm"] = "@function.outer", -- swap function with previous
                --   },
                -- },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]k"] = { query = "@call.outer", desc = "Next function call start" },
                        ["]f"] = { query = "@function.outer", desc = "Next [F]unction start" },
                        ["]c"] = { query = "@class.outer", desc = "Next [C]lass start" },
                        ["]i"] = { query = "@conditional.outer", desc = "Next [I]f start" },
                        ["]l"] = { query = "@loop.outer", desc = "Next [L]oop start" },
                    },
                    goto_next_end = {
                        ["]K"] = { query = "@call.outer", desc = "Next function call end" },
                        ["]F"] = { query = "@function.outer", desc = "Next [F]unction end" },
                        ["]C"] = { query = "@class.outer", desc = "Next [C]lass end" },
                        ["]I"] = { query = "@conditional.outer", desc = "Next [I]f end" },
                        ["]L"] = { query = "@loop.outer", desc = "Next [L]oop end" },
                    },
                    goto_previous_start = {
                        ["[k"] = { query = "@call.outer", desc = "Prev function call start" },
                        ["[f"] = { query = "@function.outer", desc = "Prev [F]unction start" },
                        ["[c"] = { query = "@class.outer", desc = "Prev [C]lass start" },
                        ["[i"] = { query = "@conditional.outer", desc = "Prev [I]f start" },
                        ["[l"] = { query = "@loop.outer", desc = "Prev [L]oop start" },
                    },
                    goto_previous_end = {
                        ["[K"] = { query = "@call.outer", desc = "Prev function call end" },
                        ["[F"] = { query = "@function.outer", desc = "Prev [F]unction end" },
                        ["[C"] = { query = "@class.outer", desc = "Prev [C]lass end" },
                        ["[I"] = { query = "@conditional.outer", desc = "Prev [I]f end" },
                        ["[L"] = { query = "@loop.outer", desc = "Prev [L]oop end" },
                    },
                },
            },
        })

        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end,
}
