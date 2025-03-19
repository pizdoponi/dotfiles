vim.cmd("cnoreabbrev tt ToggleTerm")

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
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
            direction = "vertical",
            size = function(term)
                if term.direction == "horizontal" then
                    return height * 0.5
                elseif term.direction == "vertical" then
                    return width * 0.5
                end
            end,
            float_opts = {
                border = "single",
                width = width * 0.5,
                height = height * 0.5,
                title_pos = "center",
            },
            hide_numbers = false,
            shade_terminals = false,
        })

        vim.keymap.set("n", "<leader>t<down>", function()
            vim.cmd(vim.v.count1 .. "ToggleTerm direction=horizontal")
        end, { desc = "[t]erminal down" })
        vim.keymap.set("n", "<leader>t<right>", function()
            vim.cmd(vim.v.count1 .. "ToggleTerm direction=vertical")
        end, { desc = "[t]erminal right" })

        vim.keymap.set("n", "<leader>ts", "<cmd>TermSelect<cr>", { desc = "[t]erminal [s]elect" })
    end,
}
