return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
        local width = vim.o.columns
        local height = vim.o.lines
        require("toggleterm").setup({
            open_mapping = "<C-t>",
            insert_mappings = true,   -- whether or not the open mapping applies in insert mode
            terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
            size = function(term)
                if term.direction == "horizontal" then
                    return height * 0.5
                elseif term.direction == "vertical" then
                    return width * 0.5
                end
            end,
            direction = "float",
            float_opts = {
                border = "curved",
                width = math.floor(width * 0.9),
                height = math.floor(height * 0.9),
                title_pos = "left",
            },
        })

        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "exit terminal mode" })

        vim.keymap.set("n", "<leader>t<down>", function()
            local count = vim.v.count
            if count == 0 then
                count = 1
            end
            vim.cmd(count .. "ToggleTerm direction=horizontal")
        end, { desc = "[t]erminal down" })
        vim.keymap.set("n", "<leader>t<right>", function()
            local count = vim.v.count
            if count == 0 then
                count = 1
            end
            vim.cmd(count .. "ToggleTerm direction=vertical")
        end, { desc = "[t]erminal right" })

        vim.keymap.set("n", "<leader>ts", "<cmd>TermSelect<cr>", { desc = "[t]erminal [s]elect" })

        require("which-key").add({ { "<leader>t", group = "[t]erminal" } })
    end,
}
