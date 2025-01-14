local ft_to_repl = {
    python = "ipython",
    julia = "julia",
    lua = "lua",
    racket = "racket",
}
local fts = vim.tbl_keys(ft_to_repl)

return {
    "milanglacier/yarepl.nvim",
    cmd = "REPLStart",
    ft = fts,
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            desc = "Set localleader mappings for yarepl",
            pattern = fts,
            callback = function(opts)
                local repl = ft_to_repl[vim.bo.filetype]
                repl = repl and ("-" .. repl) or ""

                vim.keymap.set("n", "<localleader>rs", "<Plug>(REPLStart" .. repl .. ")", {
                    buffer = opts.buf,
                    desc = "Start REPL",
                })
                vim.keymap.set("n", "<localleader>rl", "<Plug>(REPLSendLine)", {
                    buffer = opts.buf,
                    desc = "Send line to REPL",
                })
                vim.keymap.set("n", "<localleader>re", "<Plug>(REPLSendOperator)", {
                    buffer = opts.buf,
                    desc = "Send selection to REPL",
                })
                vim.keymap.set("v", "<localleader>re", "<Plug>(REPLSendVisual)", {
                    buffer = opts.buf,
                    desc = "Send selection to REPL",
                })
                vim.keymap.set("n", "<localleader>ri", function()
                    vim.cmd("REPLFocus")
                    vim.api.nvim_feedkeys("i", "n", true)
                end, {
                    buffer = opts.buf,
                    desc = "Focus REPL and enter insert mode",
                })
                vim.keymap.set("n", "<localleader>rb", function()
                    local cursor_pos = vim.api.nvim_win_get_cursor(0)
                    vim.cmd("normal! ggVG")
                    vim.cmd("REPLSendVisual")
                    vim.api.nvim_win_set_cursor(0, cursor_pos)
                end, {
                    buffer = opts.buf,
                    desc = "Send entire buffer to REPL",
                })
            end,
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "REPL",
            callback = function()
                vim.keymap.set("n", "<localleader>rr", "<cmd>quit<cr>", {
                    desc = "Hide REPL",
                })
            end,
        })

        pcall(function()
            require("which-key").add({ { "<localleader>r", "[r]epl" } })
        end)
    end,
    config = function()
        local yarepl = require("yarepl")
        require("yarepl").setup({
            wincmd = "vertical split",
            metas = {
                julia = { cmd = "julia", formatter = yarepl.formatter.bracketed_pasting },
                lua = { cmd = "lua", formatter = yarepl.formatter.bracketed_pasting },
                racket = { cmd = "racket", formatter = yarepl.formatter.trim_empty_lines },
                aichat = false,
                radian = false,
                python = false,
                R = false,
                bash = false,
                zsh = false,
                ipython = { cmd = "ipython --no-confirm-exit", formatter = yarepl.formatter.bracketed_pasting },
                py = { cmd = "ipython --no-confirm-exit", formatter = yarepl.formatter.bracketed_pasting },
                garfield_ipython = {
                    cmd = "ssh -t garfield bash -lc 'ipython --no-confirm-exit'",
                    formatter = yarepl.formatter.bracketed_pasting,
                },
            },
        })

        vim.cmd("cnoreabbrev rr REPLStart")
        vim.cmd("cnoreabbrev 2rr 2REPLStart")
    end,
}
