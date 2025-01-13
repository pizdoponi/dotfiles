return {
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lsp_defaults = require("lspconfig").util.default_config

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities =
                vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
            -- Add folding capabilities to lspconfig
            lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local bufnr = event.buf

                    -- enable inlay hints for clients that support it
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end

                    local is_using_trouble, _ = pcall(require, "trouble")

                    vim.keymap.set(
                        "n",
                        "<F2>",
                        "<cmd>lua vim.lsp.buf.rename()<cr>",
                        { buffer = bufnr, desc = "rename symbol under cursor" }
                    )
                    vim.keymap.set({ "n", "i" }, "<C-s>", function()
                        local cmp_ok, cmp = pcall(require, "cmp")
                        if cmp_ok and cmp.visible() then
                            cmp.close()
                        end
                        vim.lsp.buf.signature_help()
                    end, { buffer = bufnr, desc = "show signature" })
                    vim.keymap.set(
                        "n",
                        "<leader>.",
                        "<cmd>lua vim.lsp.buf.code_action()<cr>",
                        { buffer = bufnr, desc = "code actions" }
                    )

                    vim.keymap.set("n", "gd", function()
                        if is_using_trouble then
                            vim.cmd("Trouble lsp_definitions focus=true")
                        else
                            vim.lsp.buf.definition()
                        end
                    end, { buffer = bufnr, desc = "go to definition" })
                    vim.keymap.set("n", "gr", function()
                        if is_using_trouble then
                            vim.cmd("Trouble lsp_references focus=true")
                        else
                            vim.lsp.buf.references()
                        end
                    end, { buffer = bufnr, desc = "show references" })
                    vim.keymap.set("n", "gy", function()
                        if is_using_trouble then
                            vim.cmd("Trouble lsp_type_definitions focus=true")
                        else
                            vim.lsp.buf.type_definition()
                        end
                    end, { buffer = bufnr, desc = "go to type definition" })
                end,
            })

            -- Add borders to LSP hover and signature help
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded",
            })
            -- Add borders to diagnostic float
            vim.diagnostic.config({
                float = { border = "rounded" },
            })

            require("mason").setup({})
            ---@diagnostic disable-next-line: missing-fields
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local do_not_configure = {}
                        if vim.tbl_contains(do_not_configure, server_name) then
                            return
                        end
                        require("lspconfig")[server_name].setup({})
                    end,
                    lua_ls = function()
                        require("lspconfig").lua_ls.setup({
                            settings = {
                                Lua = {
                                    telemetry = {
                                        enable = false,
                                    },
                                },
                            },
                            on_init = function(client)
                                local join = vim.fs.joinpath
                                local path = client.workspace_folders[1].name

                                -- Don't do anything if there is project local config
                                if
                                    vim.uv.fs_stat(join(path, ".luarc.json"))
                                    or vim.uv.fs_stat(join(path, ".luarc.jsonc"))
                                then
                                    return
                                end

                                -- Apply neovim specific settings
                                local runtime_path = vim.split(package.path, ";")
                                table.insert(runtime_path, join("lua", "?.lua"))
                                table.insert(runtime_path, join("lua", "?", "init.lua"))

                                local nvim_settings = {
                                    runtime = {
                                        -- Tell the language server which version of Lua you're using
                                        version = "LuaJIT",
                                        path = runtime_path,
                                    },
                                    diagnostics = {
                                        -- Get the language server to recognize the `vim` global
                                        globals = { "vim" },
                                    },
                                    workspace = {
                                        checkThirdParty = false,
                                        library = {
                                            -- Make the server aware of Neovim runtime files
                                            vim.env.VIMRUNTIME,
                                            vim.fn.stdpath("config"),
                                        },
                                    },
                                }

                                client.config.settings.Lua =
                                    vim.tbl_deep_extend("force", client.config.settings.Lua, nvim_settings)
                            end,
                        })
                    end,
                },
            })
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
