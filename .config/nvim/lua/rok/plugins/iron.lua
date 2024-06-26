return {
    "Vigemus/iron.nvim",
    enabled = true,
    config = function()
        local iron = require("iron.core")

        iron.setup({
            config = {
                highlight_last = "IronLastSent",
                visibility = require("iron.visibility").toggle,
                scratch_repl = true,
                close_window_on_exit = true,
                scope = require("iron.scope").singelton,
                repl_definition = {
                    sh = {
                        command = { "zsh" },
                    },
                    python = require("iron.fts.python").ipython,
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
}
