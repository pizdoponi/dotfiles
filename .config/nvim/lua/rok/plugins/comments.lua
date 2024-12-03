return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        opts = {},
    },
    {
        "https://github.com/LudoPinelli/comment-box.nvim.git",
        lazy = true,
        cmd = { "CBlcbox", "CBlcline", "CBllline" },
    },
    {
        "danymat/neogen",
        cmd = { "Neogen" },
        version = "*",
        opts = { snippet_engine = "luasnip" },
    },
}
