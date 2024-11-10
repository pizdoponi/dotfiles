return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        icons = {
            mappings = false,
        },
        triggers = {
            { "<auto>", mode = "nsoc" },
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
    config = function(_, opts)
        require("which-key").setup(opts)

        require("which-key").add({
            { "<leader>w", group = "[w]indow" },
            { "<leader>b", group = "[b]uffer" },
            { "<leader>g", group = "[g]it" },
        })
    end,
}
