return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
        local width = vim.o.columns
        local height = vim.o.lines
        require("toggleterm").setup({
            open_mapping = "<C-t>",
            insert_mappings = true, -- whether or not the open mapping applies in insert mode
            terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
            size = function(term)
                if term.direction == "horizontal" then
                    return height * 0.4
                elseif term.direction == "vertical" then
                    return width * 0.4
                end
            end,
            direction = "float",
            float_opts = {
                border = "curved",
                width = math.floor(width * 0.8),
                height = math.floor(height * 0.8),
                title_pos = "left",
            },
        })

        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
        vim.keymap.set("t", "jk", [[<C-\><C-n>]])
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]])
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])

        vim.keymap.set({ "n", "t" }, "<leader>tj", function()
            local count = vim.fn.input("Count: ")
            local cmd = count .. "ToggleTerm direction=horizontal"
            vim.cmd(cmd)
        end, { desc = "[T]erminal open down" })
        vim.keymap.set({ "n", "t" }, "<leader>tl", function()
            local count = vim.fn.input("Count: ")
            local cmd = count .. "ToggleTerm direction=vertical"
            vim.cmd(cmd)
        end, { desc = "[T]erminal open left" })

        vim.keymap.set("n", "<leader>ts", "<cmd>TermSelect<cr>", { desc = "[T]erminal [S]elect" })
        vim.keymap.set("n", "<leader>tn", function()
            local count = vim.fn.input("Count: ")
            -- local name = vim.fn.input("Name: ")
            -- if name == "" then
            --     name = "Terminal " .. count
            -- end
            local direction = vim.fn.input("Direction (j/l/f): ")
            if direction == "j" then
                direction = "horizontal"
            elseif direction == "l" then
                direction = "vertical"
            else
                direction = "float"
            end
            local cmd = count .. "ToggleTerm direction=" .. direction
            vim.cmd(cmd)
        end, { desc = "[T]erminal [N]ew" })
    end,
}
