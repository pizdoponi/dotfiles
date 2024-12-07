return {
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        enabled = true,
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 100,
                    keymap = {
                        -- NOTE: accept and dismiss mapping is set in keymaps.lua
                        -- to integrate with nvim-cmp
                        accept = false,
                        accept_word = false,
                        accept_line = "<C-l>",
                        -- TODO: make the two mappings below work (conflict with nvim-cmp?)
                        next = "<C-n>",
                        prev = "<C-p>",
                        dismiss = false,
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    cvs = false,
                    env = false,
                    dot = false,
                    ["."] = false,
                },
                copilot_node_command = "node", -- Node.js version must be > 18.x
                server_opts_overrides = {},
            })
        end,
    },
    {
        "olimorris/codecompanion.nvim",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            strategies = {
                chat = {
                    adapter = "copilot",
                },
                inline = {
                    adapter = "copilot",
                },
                agent = {
                    adapter = "copilot",
                },
            },
        },
        config = true,
    },
}
