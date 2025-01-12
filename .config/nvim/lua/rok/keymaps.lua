vim.keymap.set("n", "yc", "yygccp", { desc = "Yank and Comment" })

-- alt delete will delete a  word, like in all other programs and editors
vim.keymap.set("i", "<A-Bs>", "<C-w>", { desc = "Delete Word" })

-- windows
vim.keymap.set("n", "<leader>wo", ":only<cr>", { desc = "[w]indow [o]nly" })

-- buffers
vim.keymap.set("n", "<leader>bq", "<cmd>bdelete!<cr>", { desc = "[b]uffer [q]uit" })
vim.keymap.set("n", "<leader>bo", "<cmd>bufdo bd<cr>", { desc = "[b]uffer [o]nly" })

-- terminal
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Terminal Escape" })

-- very magic search
vim.keymap.set("n", "/", "/\\v", { desc = "Very Magic Search" })
vim.keymap.set("n", "?", "?\\v", { desc = "Very Magic Search" })

-- diagnostics
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "[l]og diagnostic" })

-- better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

-- searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- better yanking
vim.keymap.set("v", "p", [["_dP]], { desc = "Paste Over" }) -- paste over visual selection without yanking

-- uuid generation
vim.keymap.set("i", "guuid", function()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    local function replace(c)
        local v = (c == "x") and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format("%x", v)
    end
    local uuid = string.gsub(template, "[xy]", replace)
    vim.api.nvim_put({ uuid }, "c", true, true)
end)
