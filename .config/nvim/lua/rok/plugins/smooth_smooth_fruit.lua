return {
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        opts = { easing = "quadratic" },
        config = true,
    },
    {
        "sphamba/smear-cursor.nvim",
        -- TODO: enable this once it gets stable. keeps craching atm.
        enabled = false,
        opts = {
            stiffness = 0.7,
            trailing_stiffness = 0.4,
            trailing_exponent = 0.1,
            distance_stop_animating = 0.1,
        },
    },
}
