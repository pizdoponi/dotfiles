local format_opts = { async = true, lsp_format = "fallback" }

return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<F3>",
            function()
                require("conform").format(format_opts)
            end,
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            -- For not specified filetypes, use this default
            ["_"] = { "trim_whitespace", "trim_newlines" },
            lua = { "stylua" },
            python = { "isort", "black" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            svelte = { "prettier" },
            html = { "prettier" },
            edn = { "cljfmt" },
            plaintex = { "latexindent" },
            latex = { "latexindent" },
            tex = { "latexindent" },
            bib = { "bibtex-tidy" },
            fish = { "fish_indent" },
        },
        format_after_save = format_opts,
    },
    config = function(_, opts)
        require("conform").setup(opts)

        -- Command to toggle format on save
        local format_on_save = true
        vim.api.nvim_create_user_command("ConformToggleFormatOnSave", function()
            if format_on_save then
                format_on_save = false
                require("conform").setup({ format_after_save = false })
                print("Format on save is disabled")
            else
                format_on_save = true
                require("conform").setup({ format_after_save = format_opts })
                print("Format on save is enabled")
            end
        end, { desc = "Toggle format on save" })
    end,
}
