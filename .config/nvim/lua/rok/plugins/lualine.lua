return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            -- sections = {
            --     lualine_c = {
            --         "filename",

            --         {
            --             function()
            --                 if vim.bo.modified then
            --                     return "[UNSAVED]"
            --                 end
            --                 return ""
            --             end,
            --         },
            --     },
            -- },
        })
    end,
}
