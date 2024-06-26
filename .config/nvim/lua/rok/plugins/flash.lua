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
                function(win)
                    -- exclude non-focusable windows
                    return not vim.api.nvim_win_get_config(win).focusable
                end,
                "undotree",
            },
        },
        jump = {
            nohlsearch = true,
            autojump = false,
        },
        modes = {
            char = {
                enabled = true,
                multi_line = false,
            },
        },
    },
    -- stylua: ignore
    keys = {
        { "s", mode = { "n", "x" }, function() require("flash").jump() end,       desc = "Flash" },
        { "S", mode = "n",          function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o",          function() require("flash").remote() end,     desc = "Remote Flash" },
        -- { "R",     mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        -- { "<c-s>", mode = { "c" },      function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
}
