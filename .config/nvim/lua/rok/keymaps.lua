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
vim.cmd([[cnoreabbrev s/ s/\v]])
vim.cmd([[cnoreabbrev %s/ %s/\v]])

-- diagnostics
-- NOTE: many of the keymaps are set in after/plugin/repeatable_move.lua
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

-- @potocnik ftw
-- If copilot suggestion is visible and cmp has no selected entry,
--- <CR> will accept suggestion, otherwise if there is no
--- copilot suggestion and cmp is visible, <CR> will select
--- the first cmp entry, otherwise <CR> will just do
--- its default behavior.
vim.keymap.set("i", "<Tab>", function()
    local copilot_ok, suggestion = pcall(require, "copilot.suggestion")
    local cmp_ok, cmp = pcall(require, "cmp")
    -- if not copilot_ok, and cmp has entry, accept it
    -- this is so that cmp can work when copilot does not (=no internet connection)
    if not copilot_ok and cmp_ok and cmp.visible() and cmp.get_selected_entry() ~= nil then
        vim.defer_fn(function()
            cmp.confirm({ select = true })
        end, 5)
        return true
    end
    if
        cmp_ok
        and (
            cmp.visible() and cmp.get_selected_entry() ~= nil
            or cmp.visible() and (not suggestion or not suggestion.is_visible())
        )
    then
        vim.defer_fn(function()
            cmp.confirm({ select = true })
        end, 5)
        return true
    end
    -- if copilot suggestion is available, prefer that over cmp
    if copilot_ok and suggestion and suggestion.is_visible() then
        -- if the cmp item is not selected, but the user accepts copilot suggestion
        -- close cmp and accept copilot suggestion
        if cmp_ok and cmp.visible() then
            vim.defer_fn(function()
                cmp.close()
            end, 5)
        end
        vim.defer_fn(function()
            suggestion.accept()
        end, 5)
        return true
    end
    return "<Tab>"
end, { expr = true, remap = true })

-- if either cmp or copilot suggestion is visible, close both.
-- if neither is visible, just do the default behavior
vim.keymap.set("i", "<C-c>", function()
    local cmp_ok, cmp = pcall(require, "cmp")
    local copilot_ok, suggestion = pcall(require, "copilot.suggestion")

    local closed_something = false

    if cmp_ok and cmp.visible() then
        vim.schedule(function()
            cmp.close()
        end)
        closed_something = true
    end

    if copilot_ok and suggestion.is_visible() then
        vim.schedule(function()
            suggestion.dismiss()
        end)
        closed_something = true
    end

    if not closed_something then
        return "<C-c>"
    else
        return true
    end
end, { expr = true, remap = true })
