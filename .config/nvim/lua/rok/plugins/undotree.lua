return {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "[u]ndotree" },
    },
    config = function()
        vim.g.undotree_SplitWidth = 40
        vim.g.undotree_DiffpanelHeight = 12
        vim.g.undotree_DiffAutoOpen = 1
        vim.g.undotree_SetFocusWhenToggle = 1
    end,
}
