return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                    },
                },
            },
            extensions = {
                "oil",
                "fugitive",
                "quickfix",
                "nvim-dap-ui",
                "trouble",
                "man",
                "symbols-outline",
                "toggleterm",
                "mason",
            },
        })
    end,
}
