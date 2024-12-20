return {
    {
        "kwkarlwang/bufjump.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<A-i>",
                function()
                    require("bufjump").forward()
                end,
                desc = "bufjump forward",
            },
            {
                "<A-o>",
                function()
                    require("bufjump").backward()
                end,
                desc = "bufjump backward",
            },
        },
        opts = {
            on_success = function()
                -- restore cursor position, and center the screen
                vim.cmd([[execute "normal! g`\"zz"]])
            end,
        },
    },
    {
        "leath-dub/snipe.nvim",
        keys = {
            {
                "<leader>bs",
                function()
                    require("snipe").open_buffer_menu()
                end,
                desc = "[b]uffer [s]nipe",
            },
        },
        opts = {
            ui = { position = "topleft" },
            hints = { dictionary = "arstneiohdcxpfwluyzq" },
            sort = "last",
            text_align = "right",
        },
    },
}
