-- general
vim.keymap.set("n", "<leader>q", "<cmd>qall<cr>", { desc = "[q]uit all" })
vim.keymap.set("n", "<leader>Q", "<cmd>qall!<cr>", { desc = "USE THE FORCE LUKE" })
vim.keymap.set("n", "<esc>", function()
    local notify_ok, notify = pcall(require, "notify")
    if notify_ok then
        notify.dismiss()
    end
    vim.cmd("nohl")
    vim.cmd("echo")
    return true
end, { desc = "house keeping" })

-- tabs
vim.keymap.set("n", "g<Tab>", "<cmd>tabnext<cr>", { desc = "Tab Next" })
vim.keymap.set("n", "g<S-Tab>", "<cmd>tabprevious<cr>", { desc = "Tab Previous" })

-- windows
vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Window Split Vertical" })
vim.keymap.set("n", "<leader>-", "<cmd>split<cr>", { desc = "Window Split" })
vim.keymap.set("n", "<leader>w|", "<cmd>vsplit<cr>", { desc = "Window Split Vertical" })
vim.keymap.set("n", "<leader>w-", "<cmd>split<cr>", { desc = "Window Split" })
vim.keymap.set("n", "<leader>wo", "<cmd>only<cr>", { desc = "Window Only" })
vim.keymap.set("n", "<leader>w=", "<cmd>resize<cr>", { desc = "Window Equal" })
vim.keymap.set("n", "<leader>w_", "<cmd>vertical resize<cr>", { desc = "Window Equal" })
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>")
vim.keymap.set("n", "<leader>wmh", "<C-w>H", { desc = "Window Move Left" })
vim.keymap.set("n", "<leader>wmj", "<C-w>J", { desc = "Window Move Down" })
vim.keymap.set("n", "<leader>wmk", "<C-w>K", { desc = "Window Move Up" })
vim.keymap.set("n", "<leader>wml", "<C-w>L", { desc = "Window Move Right" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Window Quit" })
vim.keymap.set("n", "<leader>wnh", "<cmd>leftabove vnew<cr>", { desc = "[W]indow [N]ew Left" })
vim.keymap.set("n", "<leader>wnk", "<cmd>above new<cr>", { desc = "[W]indow [N]ew Above" })
vim.keymap.set("n", "<leader>wnj", "<cmd>below new<cr>", { desc = "[W]indow [N]ew Below" })
vim.keymap.set("n", "<leader>wnl", "<cmd>rightbelow vnew<cr>", { desc = "[W]indow [N]ew Right" })
vim.keymap.set("n", "<leader>wch", "<cmd>leftabove close<cr>", { desc = "[W]indow [C]lose Left" })
vim.keymap.set("n", "<leader>wck", "<cmd>above close<cr>", { desc = "[W]indow [C]lose Above" })
vim.keymap.set("n", "<leader>wcj", "<cmd>below close<cr>", { desc = "[W]indow [C]lose Below" })
vim.keymap.set("n", "<leader>wcl", "<cmd>rightbelow close<cr>", { desc = "[W]indow [C]lose Right" })

-- buffers
vim.keymap.set("n", "<leader>bq", "<cmd>bdelete!<cr>", { desc = "[b]uffer [q]uit" })
vim.keymap.set("n", "<leader>bo", "<cmd>bufdo bd<cr>", { desc = "[b]uffer [o]nly" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "[b]uffer [n]ext" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "[b]uffer [p]revious" })

-- terminal
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Terminal Escape" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Terminal Escape" })
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<CR>")

-- better scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down" })

-- moving lines
-- ISSUE: make this work
vim.keymap.set("n", "<M-j>", ":m .+1<cr>==", { desc = "Move Line Down" })      -- <alt-j> normal
vim.keymap.set("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move Lines Down" }) -- <alt-j> visual
vim.keymap.set("n", "<M-k>", ":m .-2<cr>==", { desc = "Move Line Up" })        -- <alt-k> normal
vim.keymap.set("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move Lines Up" })   -- <alt-k> visual

-- better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

-- searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- better yanking
vim.keymap.set("v", "p", [["_dP]], { desc = "Paste Over" }) -- paste over visual selection without yanking

-- @potocnik ftw
-- If copilot suggestion is visible and cmp has no selected entry,
--- <CR> will accept suggestion, otherwise if there is no
--- copilot suggestion and cmp is visible, <CR> will select
--- the first cmp entry, otherwise <CR> will just do
--- its default behavior.
vim.keymap.set("i", "<CR>", function()
    local copilot_ok, suggestion = pcall(require, "copilot.suggestion")
    local cmp_ok, cmp = pcall(require, "cmp")
    -- if not copilot_ok then
    --     return "<CR>"
    -- end
    -- if not cmp_ok then
    --     return "<CR>"
    -- end
    if
        cmp
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
    if suggestion and suggestion.is_visible() then
        vim.defer_fn(function()
            suggestion.accept()
        end, 5)
        return true
    end
    return "<CR>"
end, { expr = true, remap = true })

-- if either cmp or copilot suggestion is visible, close both.
-- if neither is visible, just do the default behavior
vim.keymap.set("i", "<C-c>", function()
    local cmp_ok, cmp = pcall(require, "cmp")
    local copilot_ok, suggestion = pcall(require, "copilot.suggestion")
    if cmp_ok or copilot_ok then
        if cmp.visible() then
            vim.schedule(function()
                cmp.close()
            end)
        end
        if suggestion.is_visible() then
            vim.schedule(function()
                suggestion.dismiss()
            end)
        end
        return true
    end
    return "<C-c>"
end, { expr = true, remap = true })
