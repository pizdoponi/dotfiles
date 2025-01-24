return {
    {
        "OscarCreator/rsync.nvim",
        lazy = true,
        build = "make",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("rsync").setup({
                sync_on_save = true,
                on_exit = function(_, _)
                    print("Rsync done")
                end,
                on_stderr = function(_, _)
                    print("Rsync failed")
                end,
            })
        end,
    },
}
