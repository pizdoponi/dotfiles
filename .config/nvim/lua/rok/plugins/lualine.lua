return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            extensions = { "oil", "fugitive", "quickfix", "nvim-dap-ui", "trouble" },
        })
    end,
}
