function _G.goto_next_trouble()
    local ok, trouble = pcall(require, "trouble")
    if not ok then
        vim.notify("Trouble with Trouble", vim.log.levels.ERROR)
        return
    end
    if not trouble.is_open() then
        vim.notify("No trouble buffer is opened", vim.log.levels.WARN)
        return
    end
    trouble.next({ skip_groups = true, jump = true })
end

function _G.goto_prev_trouble()
    local ok, trouble = pcall(require, "trouble")
    if not ok then
        vim.notify("Trouble with Trouble", vim.log.levels.ERROR)
        return
    end
    if not trouble.is_open() then
        vim.notify("No trouble buffer is opened", vim.log.levels.WARN)
        return
    end
    trouble.prev({ skip_groups = true, jump = true })
end

return {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
        height = 30,
        keys = {
            ["<tab>"] = "next",
            ["<s-tab>"] = "prev",
        },
    },
    keys = {
        { "<leader>ll", "<cmd>Trouble<cr>", desc = ":Trouble" },
        { "<leader>ld", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", desc = "[l]ist [d]iagnostics" },
        { "<leader>lD", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "[l]ist workspace [D]iagnostics" },
        { "<leader>lq", "<cmd>Trouble qflist toggle focus=true<cr>", desc = "[l]ist [q]uickfix" },
        { "<leader>lc", "<cmd>Trouble todo toggle focus=true<cr>", desc = "[l]ist [c]omments" },
    },
    config = function(_, opts)
        require("trouble").setup(opts)

        local last_trouble_mode = nil

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
            pattern = "trouble",
            callback = function()
                -- TODO: get current trouble mode
            end,
        })

        vim.keymap.set("n", "]l", _G.goto_next_trouble, { desc = "Next trouble" })
        vim.keymap.set("n", "[l", _G.goto_prev_trouble, { desc = "Previous trouble" })

        -- vim.keymap.set("n", "<leader>ll", function()
        --     vim.cmd([[ lua require("trouble").toggle(last_trouble_mode) ]])
        -- end)
    end,
}
