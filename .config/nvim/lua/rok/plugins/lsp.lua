return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        event = "VeryLazy",
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
        init = function()
            vim.g.lsp_zero_extend_cmp = false
        end,
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            -- NOTE: hover on K is set in folds.lua
            lsp_zero.on_attach(function(client, bufnr)
                -- Enable inline hints if supported by the lsp server
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end

                vim.keymap.set({ "n", "i" }, "<C-s>", function()
                    local cmp_ok, cmp = pcall(require, "cmp")
                    if cmp_ok and cmp.visible() then
                        cmp.close()
                    end
                    vim.cmd([[lua vim.lsp.buf.signature_help()]])
                end, { buffer = bufnr, desc = "show signature" })
                vim.keymap.set(
                    "n",
                    "<F2>",
                    "<cmd>lua vim.lsp.buf.rename()<cr>",
                    { buffer = bufnr, desc = "rename symbol under cursor" }
                )
                vim.keymap.set("n", "gd", function()
                    local is_using_trouble, _ = pcall(require, "trouble")
                    if is_using_trouble then
                        vim.cmd("Trouble lsp_definitions focus=true")
                    else
                        vim.lsp.buf.definition()
                    end
                end, { buffer = bufnr, desc = "go to definition" })
                vim.keymap.set("n", "gr", function()
                    local is_using_trouble, _ = pcall(require, "trouble")
                    if is_using_trouble then
                        vim.cmd("Trouble lsp_references focus=true")
                    else
                        vim.lsp.buf.references()
                    end
                end, { buffer = bufnr, desc = "show references" })
                vim.keymap.set(
                    "n",
                    "gy",
                    vim.lsp.buf.type_definition,
                    { buffer = bufnr, desc = "go to type definition" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>.",
                    "<cmd>lua vim.lsp.buf.code_action()<cr>",
                    { buffer = bufnr, desc = "code actions" }
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

            require("mason").setup({})
            require("mason-lspconfig").setup({
                handlers = {
                    -- comment the line below to disable automatic setup of not manually configured servers
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                    end,
                    -- we use basedpyright in this house
                    pyright = lsp_zero.noop,
                },
            })

            -- setup LSPs that are not installed with Mason
            -- (they probably arent't available in the registry)
            -- but lspconfig has a config for them.
            require("lspconfig").racket_langserver.setup({})
            -- setup LSPs that lspconfig doesn't have a config for
            -- there are none atm. lspconfig has good support :)
        end,
    },
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        ft = "lua",
        dependencies = { "Bilal2453/luvit-meta" },
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
}
