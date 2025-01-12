return {
    "milanglacier/yarepl.nvim",
    cmd = "REPLStart",
    ft = { "python", "julia", "lua", "racket" },
    init = function()
        vim.api.nvim_create_autocmd({ "BufReadPost", "BufNew" }, {
            desc = "Set localleader mappings for yarepl",
            pattern = { "*.py", "*.jl", "*.rkt" },
            callback = function(opts)
                local yarepl = require("yarepl")
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
                vim.keymap.set("n", "<localleader>rf", function()
                    local cursor_pos = vim.api.nvim_win_get_cursor(0)
                    vim.cmd("normal! gg")
                    vim.cmd("REPLSendOperator")
                    vim.api.nvim_feedkeys("G", "n", true)
                    vim.api.nvim_win_set_cursor(0, cursor_pos)
                end, {
                    buffer = opts.buf,
                    desc = "Send entire file to REPL",
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
