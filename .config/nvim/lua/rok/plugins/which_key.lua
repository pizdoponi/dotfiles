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
            { "<leader>gd", group = "[g]it [d]iff" },
            { "<leader>gt", group = "[g]it [t]oggle" },
            { "<leader>l", group = "[l]og" },
            { "<leader>t", group = "[t]erm/[t]est" },
            { "<leader>s", group = "[s]earch" },
            { "<leader>sn", group = "[s]earch [n]eovim" },
            { "<leader>d", group = "[d]ebug" },
            { "<leader>dl", group = "[d]ebug [l]og" },
            { "<leader>r", group = "[r]epl" },
            { "<leader>T", group = "[T]reewalker" },
            { "<leader>;", group = "Swap next" },
            { "<leader>,", group = "Swap prev" },
        })
    end,
}
