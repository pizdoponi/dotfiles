return {
    "Vigemus/iron.nvim",
    lazy = true,
    ft = { "python", "lua", "julia" },
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
                    python = {
                        command = { "ipython", "--no-autoindent" },
                        format = require("iron.fts.common").bracketed_paste,
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
                remove_mark = nil,
                interrupt = "<leader>rh", -- [r]epl [h]alt
                exit = "<leader>rd",
                clear = "<leader>r<C-l>",
            },
            highlight = {
                italic = true,
            },
            ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
        })

        local function iron_insert_mode()
            pcall(function()
                vim.cmd("IronFocus")
            end)
            -- enter insert mode in the repl in either case
            vim.api.nvim_feedkeys("i", "n", false)
        end

        vim.keymap.set("n", "<leader>rr", "<cmd>IronRepl<cr>", { desc = "iron_repl_toggle" })
        vim.keymap.set("t", "<leader>rr", "<C-\\><C-n><wincmd>w<cmd>IronHide<cr>", { desc = "iron_repl_hide" })
        vim.keymap.set("n", "<leader>ri", iron_insert_mode, { desc = "iron_repl_insert" })
        vim.keymap.set("n", "<leader>rG", function()
            local ft = vim.bo.filetype
            local cursor_row = vim.api.nvim_win_get_cursor(0)[1]
            local lines_until_EOF = vim.api.nvim_buf_get_lines(0, cursor_row - 1, -1, false)
            iron.send(ft, lines_until_EOF)
        end, { desc = "iron_repl_send_until_EOF" })
    end,
}
