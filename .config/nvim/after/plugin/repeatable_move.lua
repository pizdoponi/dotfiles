local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
local repeatable_move = ts_repeat_move.make_repeatable_move_pair

local goto_next_error = function()
    vim.cmd("lua vim.diagnostic.goto_next({severity=vim.diagnostic.severity.ERROR})")
end
local goto_prev_error = function()
    vim.cmd("lua vim.diagnostic.goto_prev({severity=vim.diagnostic.severity.ERROR})")
end

local goto_next_spell = function()
    vim.cmd("normal! ]s")
end
local goto_prev_spell = function()
    vim.cmd("normal! [s")
end

Goto_prev_qflist = function()
    if require("trouble").is_open() then
        require("trouble").prev({ skip_groups = true, jump = true })
    else
        local ok, err = pcall(vim.cmd.cprev)
        if not ok then
            vim.notify(err, vim.log.levels.ERROR)
        end
    end
end

Goto_next_qflist = function()
    if require("trouble").is_open() then
        require("trouble").next({ skip_groups = true, jump = true })
    else
        local ok, err = pcall(vim.cmd.cnext)
        if not ok then
            vim.notify(err, vim.log.levels.ERROR)
        end
    end
end

local repeat_goto_next_diagnostic, repeat_goto_prev_diagnostic =
    repeatable_move(vim.diagnostic.goto_next, vim.diagnostic.goto_prev)
local repeat_goto_next_error, repeat_goto_prev_error = repeatable_move(goto_next_error, goto_prev_error)
local repeat_goto_next_spell, repeat_goto_prev_spell = repeatable_move(goto_next_spell, goto_prev_spell)

vim.keymap.set({ "n", "x", "o" }, "]d", repeat_goto_next_diagnostic, { desc = "Next diagnostic" })
vim.keymap.set({ "n", "x", "o" }, "[d", repeat_goto_prev_diagnostic, { desc = "Prev diagnostic" })
vim.keymap.set({ "n", "x", "o" }, "]e", repeat_goto_next_error, { desc = "Next error" })
vim.keymap.set({ "n", "x", "o" }, "[e", repeat_goto_prev_error, { desc = "Prev error" })

vim.keymap.set({ "n", "x", "o" }, "]s", repeat_goto_next_spell, { desc = "Next spell" })
vim.keymap.set({ "n", "x", "o" }, "[s", repeat_goto_prev_spell, { desc = "Prev spell" })
