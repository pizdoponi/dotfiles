return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        search = {
            exclude = {
                "notify",
                "cmp_menu",
                "noice",
                "flash_prompt",
                "telescope",
                "undotree",
                function(win)
                    -- exclude non-focusable windows
                    return not vim.api.nvim_win_get_config(win).focusable
                end,
            },
        },
        jump = {
            nohlsearch = true,
            autojump = false,
        },
        modes = {
            char = {
                enabled = false,
                multi_line = false,
            },
        },
    },
    keys = {
        {
            "s",
            mode = { "n", "x" },
            function()
                require("flash").jump()
            end,
            desc = "Flash",
        },
        {
            "S",
            mode = "n",
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash",
        },
        -- duplicate of "s", but to make it available always in all cases
        -- because some plugins (especially git plugins) hijack the "s" key
        -- even in insert mode
        {
            "<A-s>",
            mode = { "n", "x", "i" },
            function()
                require("flash").jump()
            end,
            desc = "Flash",
        },
    },
}
