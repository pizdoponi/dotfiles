return {
        "ThePrimeagen/harpoon",
        enabled = true,
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup({})
            vim.keymap.set("n", "<leader>ba", function()
                harpoon:list():append()
            end, { desc = "[a]dd to harpoon" })
            vim.keymap.set("n", "<leader>bh", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = "[h]arpoon" })

            vim.keymap.set("n", "<C-0>", function()
                harpoon:list():select(1)
            end, { desc = "[G]oto 1st harpoon buffer" })
            vim.keymap.set("n", "<C-4>", function()
                harpoon:list():select(2)
            end, { desc = "[G]oto 2nd harpoon buffer" })
            vim.keymap.set("n", "<C-5>", function()
                harpoon:list():select(3)
            end, { desc = "[G]oto 3rd harpoon buffer" })
            vim.keymap.set("n", "<C-6>", function()
                harpoon:list():select(4)
            end, { desc = "[G]oto 4th harpoon buffer" })

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<S-left>", function()
                harpoon:list():prev()
            end)
            vim.keymap.set("n", "<S-right>", function()
                harpoon:list():next()
            end)
        end,
    }
