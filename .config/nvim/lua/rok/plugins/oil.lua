return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        { "<leader>o", "<cmd>Oil<cr>", desc = "coconut [o]il" },
    },
    opts = {
        default_file_explorer = true,
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<BS>"] = "actions.parent",
            ["<Tab>"] = "actions.preview",
            ["<leader>o"] = "actions.close",
            ["<C-d>"] = "actions.preview_scroll_down",
            ["<C-u>"] = "actions.preview_scroll_up",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
        },
        use_default_keymaps = false,
        lsp_file_methods = {
            enabled = true,
            timeout_ms = 3000,
            autosave_changes = true,
        },
        view_options = {
            show_hidden = true,
            case_insensitive = true,
        },
        experimental_watch_for_changes = true,
        skip_confirm_for_simple_edits = true,
        git = {
            add = function(_)
                return false
            end,
            -- automatically stage file renames
            mv = function(_, _)
                return true
            end,
            rm = function(_)
                return false
            end,
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
}
