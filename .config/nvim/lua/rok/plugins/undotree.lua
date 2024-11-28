return {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreePersistUndo" },
    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "[u]ndotree" },
    },
    config = function()
        vim.g.undotree_WindowLayout = 2
        vim.g.undotree_SplitWidth = 40
        vim.g.undotree_DiffpanelHeight = 10
        vim.g.undotree_DiffAutoOpen = 1
        vim.g.undotree_SetFocusWhenToggle = 1

        vim.cmd([[
            function g:Undotree_CustomMap()
                nmap <buffer> <up> <plug>UndotreeNextState
                nmap <buffer> <down> <plug>UndotreePreviousState
            endfunc
        ]])
    end,
}
