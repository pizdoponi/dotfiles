return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<F3>",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
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
        },
        format_after_save = {
            async = true,
            lsp_format = "fallback",
        },
    },
}
