return {
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
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
                        -- NOTE: confirm mapping is set in keymaps.lua
                        accept = false,
                        accept_word = false,
                        accept_line = false,
                        next = "<C-j>",
                        prev = "<C-k>",
                        dismiss = false,
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    env = false,
                    ["."] = false,
                },
                copilot_node_command = "node", -- Node.js version must be > 18.x
                server_opts_overrides = {},
            })
        end,
    },
}
