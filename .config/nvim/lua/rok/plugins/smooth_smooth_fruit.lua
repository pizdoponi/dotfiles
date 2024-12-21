return {
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        opts = { easing = "quadratic" },
        config = true,
    },
    {
        "sphamba/smear-cursor.nvim",
        event = "VeryLazy",
        enabled = true,
        opts = {
            stiffness = 0.8, -- 0.6      [0, 1]
            trailing_stiffness = 0.6, -- 0.3      [0, 1]
            trailing_exponent = 0, -- 0.1      >= 0
            distance_stop_animating = 0.5, -- 0.1      > 0
            hide_target_hack = false, -- true     boolean
            -- stiffness = 0.7,
            -- trailing_stiffness = 0.4,
            -- trailing_exponent = 0.1,
            -- distance_stop_animating = 0.1,
        },
    },
}
