return {
    {
        "Vigemus/iron.nvim",
        enabled = true,
        config = function()
            local iron = require("iron.core")

            iron.setup({
                config = {
                    scratch_repl = true,
                    close_window_on_exit = true,
                    repl_definition = {
                        sh = {
                            command = { "zsh" },
                            -- python = require("iron.fts.python").ipython,
                        },
                    },
                    repl_open_cmd = require("iron.view").split.vertical.botright(function()
                        return vim.o.columns * 0.5
                    end),
                },
                keymaps = {
                    send_motion = "<leader>re",
                    visual_send = "<leader>re",
                    send_file = "<leader>rf",
                    send_line = "<leader>rl",
                    send_until_cursor = "<leader>ru",
                    send_mark = "<leader>rs", -- [r]epl [s]end mark
                    mark_motion = "<leader>rm",
                    mark_visual = "<leader>rm",
                    remove_mark = "<leader>rd",
                    interrupt = "<leader>rh", -- [r]epl [h]alt
                    exit = "<leader>rq",
                    clear = "<leader>rc",
                },
                highlight = {
                    italic = true,
                },
                ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
            })

            vim.keymap.set("n", "<leader>rr", "<cmd>IronRepl<cr>", { desc = "[r]epl toggle" })
            vim.keymap.set("n", "<leader>ri", "<cmd>IronFocus<cr>a", { desc = "[r]epl [i]nsert" })
            -- TODO: add IronWatch
            -- vim.keymap.set("n", "<leader>rw", "<cmd>IronWatch<cr>a", { desc = "[r]epl watch" })
            vim.keymap.set("t", "<leader>rr", "<C-\\><C-n><wincmd>w<cmd>IronHide<cr>", { desc = "[r]epl close" })
        end,
    },
    {
        "klen/nvim-test",
        keys = {
            { "<leader>rtf", "<cmd>TestFile<cr>", desc = "test file" },
            { "<leader>rtn", "<cmd>TestNearest<cr>", desc = "test nearest" },
            { "<leader>rts", "<cmd>TestSuite<cr>", desc = "test suite" },
            { "<leader>rtl", "<cmd>TestLast<cr>", desc = "test last" },
        },
        opts = {},
        config = function()
            require("nvim-test").setup({
                silent = true,
                term = "toggleterm",
                termOpts = {
                    direction = "vertical",
                    go_back = false,
                    -- width = 80,
                },
            })
        end,
    },
    {
        "rgroli/other.nvim",
        keys = {
            { "go", "<cmd>Other<cr>", desc = "goto other" },
            { "gO", "<cmd>OtherVSplit<cr>", desc = "goto other vsplit" },
        },
        config = function()
            require("other-nvim").setup({
                mappings = {
                    "livewire",
                    "angular",
                    "laravel",
                    "rails",
                    "golang",
                    {
                        -- python src -> test
                        pattern = "src/(.*)/(.*).py$",
                        target = "tests/%1/test_%2.py",
                        context = "test",
                    },
                },
                transformers = {
                    -- defining a custom transformer
                    lowercase = function(inputString)
                        return inputString:lower()
                    end,
                },
                style = {
                    -- How the plugin paints its window borders
                    -- Allowed values are none, single, double, rounded, solid and shadow
                    border = "solid",
                    -- Column seperator for the window
                    seperator = "|",
                    -- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
                    width = 0.8,
                    minHeight = 2,
                },
            })
        end,
    },
}
