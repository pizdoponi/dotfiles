return {
    "folke/zen-mode.nvim",
    dependencies = {
        "folke/twilight.nvim",
    },
    cmd = "ZenMode",
    opts = {
        plugins = {
            tmux = { enabled = true },
            gitsigns = { enabled = true },
        },
    },
}
