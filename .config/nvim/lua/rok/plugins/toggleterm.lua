return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<A-t>", "<cmd>ToggleTerm<cr>", { desc = "[t]oggle terminal" } },
    },
    config = function()
        local width = vim.o.columns
        local height = vim.o.lines
        require("toggleterm").setup({
            open_mapping = "<A-t>",
            insert_mappings = true, -- whether or not the open mapping applies in insert mode
            terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
            hide_numbers = false,
            size = function(term)
                if term.direction == "horizontal" then
                    return height * 0.5
                elseif term.direction == "vertical" then
                    return width * 0.5
                end
            end,
            direction = "vertical",
        })

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
    end,
}
