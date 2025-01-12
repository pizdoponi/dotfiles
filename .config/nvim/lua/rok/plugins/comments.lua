return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        opts = {
            keywords = {
                FIX = { icon = "E" },
                TODO = { icon = "T" },
                WARN = { icon = "W" },
                NOTE = { icon = "I" },
            },
        },
    },
    {
        "https://github.com/LudoPinelli/comment-box.nvim.git",
        cmd = { "CBlcbox", "CBlcline", "CBllline" },
    },
    {
        "danymat/neogen",
        cmd = { "Neogen" },
        version = "*",
        opts = { snippet_engine = "luasnip" },
    },
}
