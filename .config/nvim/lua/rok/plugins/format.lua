local format_opts = { async = true, lsp_format = "fallback" }

return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>bf",
            function()
                require("conform").format(format_opts)
            end,
            desc = "[b]uffer [f]ormat",
        },
    },
    opts = {
        formatters_by_ft = {
            -- For not specified filetypes, use this default
            ["_"] = { "trim_whitespace", "trim_newlines" },
            lua = { "stylua" },
            python = { "isort", "black", "docformatter" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            markdown = { "mdformat" },
            html = { "prettier" },
            plaintex = { "latexindent" },
            tex = { "latexindent" },
            bib = { "bibtex-tidy" },
            fish = { "fish_indent" },
        },
        format_after_save = format_opts,
    },
    config = function(_, opts)
        require("conform").setup(opts)

        -- Command to toggle format on save
        local should_format_on_save = true
        vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
            if should_format_on_save then
                should_format_on_save = false
                ---@diagnostic disable-next-line: assign-type-mismatch
                require("conform").setup({ format_after_save = false })
                vim.notify("Format on save is disabled", vim.log.levels.INFO)
            else
                should_format_on_save = true
                require("conform").setup({ format_after_save = format_opts })
                vim.notify("Format on save is enabled", vim.log.levels.INFO)
            end
        end, { desc = "Toggle format on save" })
    end,
}
