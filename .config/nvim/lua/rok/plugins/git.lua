return {
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>gtB", "<cmd>Git blame<cr>", { desc = "Git blame" })
        end,
    },
    {
        "tpope/vim-rhubarb",
        event = "VeryLazy",
    },
    {
        "NeogitOrg/neogit",
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "-" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "—" },
                    untracked = { text = "?" },
                },
                signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
                numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    follow_files = true,
                },
                auto_attach = true,
                attach_to_untracked = false,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = "single",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
                yadm = {
                    enable = false,
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]h", function()
                        if vim.wo.diff then
                            return "]h"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    map("n", "[h", function()
                        if vim.wo.diff then
                            return "[h"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    -- Actions
                    map("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage hunk" })
                    map("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset hunk" })
                    map("v", "<leader>ghs", function()
                        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Stage hunk" })
                    map("v", "<leader>ghr", function()
                        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "Reset hunk" })
                    map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage buffer" })
                    map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                    map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset buffer" })
                    map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })
                    map("n", "<leader>ghb", function()
                        gs.blame_line({ full = true })
                    end, { desc = "Blame line" })
                    map("n", "<leader>ghd", gs.diffthis, { desc = "Diff this" })
                    map("n", "<leader>ghD", function()
                        gs.diffthis("~")
                    end, { desc = "Diff this (cached)" })

                    map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted" })
                    map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle blame" })
                    map("n", "<leader>gts", gs.toggle_signs, { desc = "Toggle signs" })
                    map("n", "<leader>gtn", gs.toggle_numhl, { desc = "Toggle numhl" })
                    map("n", "<leader>gtl", gs.toggle_linehl, { desc = "Toggle linehl" })
                    map("n", "<leader>gtw", gs.toggle_word_diff, { desc = "Toggle word diff" })
                    map("n", "<leader>gta", function()
                        gs.toggle_signs()
                        gs.toggle_numhl()
                        gs.toggle_linehl()
                    end, { desc = "Toggle all" })

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
                end,
            })
        end,
    },
}
