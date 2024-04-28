return {
    "jinh0/eyeliner.nvim",
    event = "VeryLazy",
    config = function()
        require("eyeliner").setup({
            higlight_on_key = true,
            dim = true,
        })

        -- local color = "#00bfff" -- sky blue
        local color = "#ffdf00" -- golden yellow
        vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = color, bold = true })
        vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = color })
    end,
}
