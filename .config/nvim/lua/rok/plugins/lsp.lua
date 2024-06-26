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
                "n",
                "<leader>.",
                "<cmd>lua vim.lsp.buf.code_action()<cr>",
                { buffer = bufnr, desc = "Code Actions" }
            )
            vim.keymap.set(
                "n",
                "gR",
                "<cmd>Telescope lsp_references<cr>",
                { buffer = bufnr, desc = "Telescope [r]eferences" }
            )
            vim.keymap.set(
                "n",
                "gs",
                "<cmd>lua vim.lsp.buf.signature_help()<cr>",
                { buffer = bufnr, desc = "show signature" }
            )
            vim.keymap.set(
                "i",
                "<C-s>",
                "<cmd>lua vim.lsp.buf.signature_help()<cr>",
                { buffer = bufnr, desc = "show signature" }
            )
            vim.keymap.set(
                "n",
                "gt",
                "<cmd>lua vim.lsp.buf.type_definition()<cr>",
                { buffer = bufnr, desc = "goto type" }
            )
            vim.keymap.set(
                "n",
                "<F12>",
                "<cmd>lua vim.lsp.buf.rename()<cr>",
                { buffer = bufnr, desc = "next diagnostic" }
            )
            vim.keymap.set(
                "n",
                "gd",
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
                lsp_zero.default_setup,
                -- if you will have other pojects disable this
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require("lspconfig").lua_ls.setup(lua_opts)
                end,
            },
        })
    end,
}
