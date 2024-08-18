return {

    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                { "hrsh7th/cmp-nvim-lsp" },
            },
        },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        lsp_zero.extend_lspconfig()

        -- NOTE: hover on K is set in folds.lua
        lsp_zero.on_attach(function(client, bufnr)
            vim.keymap.set(
                { "n", "i" },
                "<C-s>",
                "<cmd>lua vim.lsp.buf.signature_help()<cr>",
                { buffer = bufnr, desc = "show signature" }
            )
            vim.keymap.set(
                "n",
                "<F2>",
                "<cmd>lua vim.lsp.buf.rename()<cr>",
                { buffer = bufnr, desc = "next diagnostic" }
            )
            vim.keymap.set(
                "n",
                "gx",
                "<cmd>lua vim.diagnostic.open_float()<cr>",
                { buffer = bufnr, desc = "show diagnostic" }
            )
        end)

        lsp_zero.set_server_config({
            single_file_support = true,
            capabilities = {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            },
        })

        -- set sign icons
        lsp_zero.set_sign_icons({
            error = "󰚌",
            warn = "󰈸",
            hint = "󰌵",
            info = "",
        })

        require("mason").setup({})
        require("mason-lspconfig").setup({
            handlers = {
                -- comment the line below to disable automatic setup of not manually configured servers
                lsp_zero.default_setup,
                -- if you will have other pojects disable this
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require("lspconfig").lua_ls.setup(lua_opts)
                end,
                ruff_lsp = lsp_zero.noop(),
                basedpyright = lsp_zero.noop(),
                pylsp = lsp_zero.noop(),
                pyre = lsp_zero.noop(),
                pyright = function()
                    require("lspconfig").pyright.setup({})
                end,
            },
        })
    end,
}
