return {
    {
        "amitds1997/remote-nvim.nvim",
        lazy = true,
        version = "*", -- Pin to GitHub releases
        dependencies = {
            "nvim-lua/plenary.nvim", -- For standard functions
            "MunifTanjim/nui.nvim", -- To build the plugin UI
            "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
        },
        config = function()
            -- open new wezterm tab with nvim client on connection
            require("remote-nvim").setup({
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
            require("rsync").setup({
                on_exit = function(code, command)
                    print("Rsync done")
                end,
                on_stderr = function(data, command)
                    print("Rsync failed")
                end,
            })
        end,
    },
}
