return {
    {
        "amitds1997/remote-nvim.nvim",
        lazy = true,
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("remote-nvim").setup({
                copy_dirs = {
                    data = {
                        dirs = {
                            { "lazy" },
                        },
                    },
                },
                -- open new wezterm tab with nvim client on connection
                client_callback = function(port, workspace_config)
                    local cmd = ("wezterm cli set-tab-title --pane-id $(wezterm cli spawn nvim --server localhost:%s --remote-ui) %s"):format(
                        port,
                        ("'Remote: %s'"):format(workspace_config.host)
                    )
                    if vim.env.TERM == "xterm-kitty" then
                        cmd = ("kitty -e nvim --server localhost:%s --remote-ui"):format(port)
                    end
                    vim.fn.jobstart(cmd, {
                        detach = true,
                        on_exit = function(job_id, exit_code, event_type)
                            -- This function will be called when the job exits
                            print("Client", job_id, "exited with code", exit_code, "Event type:", event_type)
                        end,
                    })
                end,
            })
        end,
    },
    {
        "nosduco/remote-sshfs.nvim",
        lazy = true,
        dependencies = { "nvim-telescope/telescope.nvim" },
        opts = {},
    },
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
