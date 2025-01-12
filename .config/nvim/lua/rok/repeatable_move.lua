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

local goto_next_qflist = function()
    vim.cmd("cnext")
end
local goto_prev_qflist = function()
    vim.cmd("cprev")
end

local repeat_goto_next_diagnostic, repeat_goto_prev_diagnostic =
    repeatable_move(vim.diagnostic.goto_next, vim.diagnostic.goto_prev)
local repeat_goto_next_error, repeat_goto_prev_error = repeatable_move(goto_next_error, goto_prev_error)
local repeat_goto_next_spell, repeat_goto_prev_spell = repeatable_move(goto_next_spell, goto_prev_spell)
local repeat_goto_next_qflist, repeat_goto_prev_qflist = repeatable_move(goto_next_qflist, goto_prev_qflist)
local repeat_goto_next_trouble, repeat_goto_prev_trouble = repeatable_move(_G.goto_next_trouble, _G.goto_prev_trouble)

vim.keymap.set({ "n", "x", "o" }, "]d", repeat_goto_next_diagnostic, { desc = "Next diagnostic" })
vim.keymap.set({ "n", "x", "o" }, "[d", repeat_goto_prev_diagnostic, { desc = "Prev diagnostic" })
vim.keymap.set({ "n", "x", "o" }, "]e", repeat_goto_next_error, { desc = "Next error" })
vim.keymap.set({ "n", "x", "o" }, "[e", repeat_goto_prev_error, { desc = "Prev error" })

vim.keymap.set({ "n", "x", "o" }, "]q", repeat_goto_next_qflist, { desc = "Next qflist" })
vim.keymap.set({ "n", "x", "o" }, "[q", repeat_goto_prev_qflist, { desc = "Prev qflist" })

vim.keymap.set({ "n", "x", "o" }, "]s", repeat_goto_next_spell, { desc = "Next spell" })
vim.keymap.set({ "n", "x", "o" }, "[s", repeat_goto_prev_spell, { desc = "Prev spell" })

vim.keymap.set({ "n", "x", "o" }, "]l", repeat_goto_next_trouble, { desc = "Next trouble" })
vim.keymap.set({ "n", "x", "o" }, "[l", repeat_goto_prev_trouble, { desc = "Prev trouble" })
