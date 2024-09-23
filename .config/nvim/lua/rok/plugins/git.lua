return {
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    {
        "NeogitOrg/neogit",
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
        },
        cmd = "Neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = true,
    },
    {
        "sindrets/diffview.nvim",
        lazy = true,
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>gdd", "<cmd>DiffviewOpen<cr>", desc = "[D]iffview open" },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "-" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "%" },
                    untracked = { text = "┆" },
                },
                signs_staged = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "-" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "%" },
                    untracked = { text = "┆" },
                },
                signs_staged_enable = true,
                signcolumn = false,
                numhl = false,
                linehl = false,
                word_diff = false,
                watch_gitdir = {
                    follow_files = true,
                },
                auto_attach = true,
                attach_to_untracked = false,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                    use_focus = true,
                },
                current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
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
                on_attach = function(bufnr)
                    local gitsigns = require("gitsigns")

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true })
                        else
                            gitsigns.nav_hunk("next")
                        end
                    end)

                    map("n", "[c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true })
                        else
                            gitsigns.nav_hunk("prev")
                        end
                    end)

                    -- Actions
                    map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "[s]tage hunk" })
                    map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "[r]eset hunk" })
                    map("v", "<leader>gs", function()
                        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "[s]tage hunk" })
                    map("v", "<leader>gr", function()
                        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "[r]eset hunk" })
                    map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[S]tage buffer" })
                    map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "[u]ndo stage hunk" })
                    map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "[R]eset buffer" })
                    map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "[p]review hunk" })
                    map("n", "<leader>gb", function()
                        gitsigns.blame_line({ full = true })
                    end)
                    map("n", "<leader>gdi", gitsigns.diffthis, { desc = "[d]iff againts [i]ndex" })
                    map("n", "<leader>gdh", function()
                        gitsigns.diffthis("@")
                    end, { desc = "[d]iff againts [h]ead" })
                    map("n", "<leader>gtd", gitsigns.toggle_deleted, { desc = "[t]oggle [d]eleted" })
                    map("n", "<leader>gtl", gitsigns.toggle_linehl, { desc = "[t]oggle [l]inehl" })
                    map("n", "<leader>gtn", gitsigns.toggle_numhl, { desc = "[t]oggle [n]umhl" })
                    map("n", "<leader>gtw", gitsigns.toggle_word_diff, { desc = "[t]oggle [w]ord diff" })
                    map("n", "<leader>gts", gitsigns.toggle_signs, { desc = "[t]oggle [s]igns" })
                    map("n", "<leader>gta", function()
                        gitsigns.toggle_signs()
                        gitsigns.toggle_numhl()
                        gitsigns.toggle_linehl()
                    end, { desc = "[t]oggle [a]ll" })
                    map("n", "<leader>gtb", gitsigns.blame, { desc = "[t]oggle [b]lame" })
                    map(
                        "n",
                        "<leader>gtB",
                        gitsigns.toggle_current_line_blame,
                        { desc = "[t]oggle current line [B]lame" }
                    )

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
            })
        end,
    },
}
