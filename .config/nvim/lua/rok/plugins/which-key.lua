return {
    "folke/which-key.nvim",
    lazy = false,
    priority = 700,
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    opts = {
        operators = { gc = "Comments" },
        defaults = {
            ["<leader>w"] = { name = "[w]indow" },
            ["<leader>wm"] = { name = "[w]indow [m]ove" },
            ["<leader>wn"] = { name = "[w]indow [n]ew" },
            ["<leader>wc"] = { name = "[w]indow [c]lose" },
            ["<leader>b"] = { name = "[b]uffer" },
            ["<leader>t"] = { name = "[t]erminal" },
            ["<leader>s"] = { name = "[s]earch" },
            ["<leader>x"] = { name = "diagnosti[x]" },
            ["<leader>g"] = { name = "[g]it" },
            ["<leader>gh"] = { name = "[g]it [h]unk" },
            ["<leader>gt"] = { name = "[g]it [t]oggle" },

            ["<leader>r"] = {
                name = "[r]un",
                e = "[r]epl [e]val",
                f = "[r]epl [f]ile",
                l = "[r]epl [l]ine",
                u = "[r]epl [u]ntil cursor",
                s = "[r]epl [s]end mark",
                m = "[r]epl [m]ark",
                d = "[r]epl [d]elete mark",
                h = "[r]epl [h]alt",
                q = "[r]epl [q]uit",
                c = "[r]epl [c]lear",
                t = "[r]un [t]est",
            },
        },
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.register(opts.defaults)
    end,
}
