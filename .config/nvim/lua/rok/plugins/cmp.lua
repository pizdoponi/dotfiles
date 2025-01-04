return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = { "rafamadriz/friendly-snippets" },
        },
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-calc",
        "lukas-reineke/cmp-rg",
        "lukas-reineke/cmp-under-comparator",
        "kdheepak/cmp-latex-symbols",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        -- load the snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completeopt = "menu,menuone,preview,noinsert,noselect",
            view = {
                entries = { name = "custom", selection_order = "near_cursor" },
            },
            sources = {
                { name = "nvim_lsp_signature_help", group_index = 0, priority = 2 },
                { name = "nvim_lsp", group_index = 1 },
                { name = "path", group_index = 2 },
                { name = "calc", group_index = 2 },
                { name = "nvim_lua", group_index = 2 },
                { name = "luasnip", group_index = 2 },
                { name = "buffer", group_index = 2, max_item_count = 5 },
                {
                    name = "rg",
                    keyword_length = 3,
                    group_index = 2,
                    max_item_count = 5,
                },
                {
                    name = "latex_symbols",
                    option = {
                        strategy = 0, -- mixed
                    },
                    max_item_count = 20,
                },
            },
            sorting = {
                priority_weight = 2,
                comparators = {
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.kind,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.scopes,
                    cmp.config.compare.locality,
                    cmp.config.compare.offset,
                    require("cmp-under-comparator").under,
                    cmp.config.compare.length,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.order,
                },
            },
            window = {
                completion = {
                    border = "single",
                    scrollbar = false,
                    col_offset = -3,
                    winhighlight = "Normal:Normal",
                },
                documentation = {
                    border = "single",
                    scrollbar = false,
                },
            },
            -- NOTE: confirm and cancel mappings are set in keymaps.lua
            mapping = {
                ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
                ["<C-e>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
                ["<C-z>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i" }),
                ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i" }),
                ["<C-f>"] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-b>"] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            preselect = cmp.PreselectMode.None,
            formatting = {
                expandable_indicator = true,
                -- changing the order of fields so the icon is the first
                fields = { "kind", "abbr" },
                -- uncomment the line below to include source name in the completion menu
                -- fields = { "kind", "abbr", "menu" },
                format = function(entry, item)
                    local kind_icon = {
                        Text = "",
                        Class = "󱗂",
                        Interface = "󱖿",
                        Constructor = "",
                        Method = "󰊕",
                        Function = "󰊕",
                        Field = "",
                        Variable = "",
                        Property = "",
                        Module = "󰅩",
                        Unit = "󰬺",
                        Value = "󰎠",
                        Enum = "󱅉",
                        EnumMember = "󱅈",
                        Keyword = "󰌋",
                        Snippet = "",
                        Color = "󰏘",
                        File = "󰈙",
                        Reference = "",
                        Folder = "󰉋",
                        Constant = "󰏿",
                        Struct = "󰚄",
                        Event = "",
                        Operator = "",
                        TypeParameter = "",
                    }

                    item.menu = "[" .. entry.source.name .. "]"

                    if entry.source.name == "calc" then
                        item.kind = ""
                        item.kind_hl_group = "CmpItemKindCalc"
                    elseif entry.source.name == "rg" then
                        item.kind = ""
                        item.kind_hl_group = "CmpItemKindRg"
                    elseif entry.source.name == "buffer" then
                        item.kind = "󰦨"
                    else
                        item.kind = kind_icon[item.kind] or ""
                    end

                    return item
                end,
            },
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
            ---@diagnostic disable-next-line: missing-fields
            matching = { disallow_symbol_nonprefix_matching = false },
        })

        -- @potocnik ftw
        -- If copilot suggestion is visible and cmp has no selected entry,
        --- <CR> will accept suggestion, otherwise if there is no
        --- copilot suggestion and cmp is visible, <CR> will select
        --- the first cmp entry, otherwise <CR> will just do
        --- its default behavior.
        vim.keymap.set("i", "<Tab>", function()
            local copilot_ok, suggestion = pcall(require, "copilot.suggestion")
            -- if not copilot_ok, and cmp has entry, accept it
            -- this is so that cmp can work when copilot does not (=no internet connection)
            if not copilot_ok and cmp.visible() and cmp.get_selected_entry() ~= nil then
                vim.defer_fn(function()
                    cmp.confirm({ select = true })
                end, 5)
                return true
            end
            if

                cmp.visible() and cmp.get_selected_entry() ~= nil
                or cmp.visible() and (not suggestion or not suggestion.is_visible())
            then
                vim.defer_fn(function()
                    cmp.confirm({ select = true })
                end, 5)
                return true
            end
            -- if copilot suggestion is available, prefer that over cmp
            if copilot_ok and suggestion and suggestion.is_visible() then
                -- if the cmp item is not selected, but the user accepts copilot suggestion
                -- close cmp and accept copilot suggestion
                if cmp.visible() then
                    vim.defer_fn(function()
                        cmp.close()
                    end, 5)
                end
                vim.defer_fn(function()
                    suggestion.accept()
                end, 5)
                return true
            end
            return "<Tab>"
        end, { expr = true, remap = true })

        -- if either cmp or copilot suggestion is visible, close both.
        -- if neither is visible, just do the default behavior
        vim.keymap.set("i", "<C-c>", function()
            local copilot_ok, suggestion = pcall(require, "copilot.suggestion")

            local closed_something = false

            if cmp.visible() then
                vim.schedule(function()
                    cmp.close()
                end)
                closed_something = true
            end

            if copilot_ok and suggestion.is_visible() then
                vim.schedule(function()
                    suggestion.dismiss()
                end)
                closed_something = true
            end

            if not closed_something then
                return "<C-c>"
            else
                return true
            end
        end, { expr = true, remap = true })

        local colors = {
            -- reds
            red = "#ff0000",
            salmon = "#fa8072",
            crimson = "#dc143c",
            -- greens
            lime = "#00ff00",
            green = "#008000",
            olive = "#808000",
            teal = "#008080",
            -- blues
            blue = "#0000ff",
            cyan = "#00ffff",
            sky = "#87ceeb",
            navy = "#000080",
            -- yellows
            yellow = "#ffff00",
            gold = "#ffd700",
            khaki = "#f0e68c",
            moccasin = "#ffe4b5",
            -- purples
            magenta = "#ff00ff",
            purple = "#800080",
            indigo = "#4b0082",
            violet = "#ee82ee",
            lavender = "#e6e6fa",

            -- oranges
            orange = "#ffa500",
            coral = "#ff7f50",

            -- pinks
            pink = "#ffc0cb",
            hotpink = "#ff69b4",
            deeppink = "#ff1493",

            -- browns
            brown = "#a52a2a",
            maroon = "#800000",
            chocolate = "#d2691e",
        }

        -- color of text in the completion menu
        vim.api.nvim_set_hl(0, "CmpItemAbbr", { bg = "NONE", link = "Normal" })
        -- color of the matched text
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = colors.gold })
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
        -- strikethrough deprecated items
        vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
        -- highlight the kind of the item
        -- lsp icons
        --
        -- classes are red
        -- vars are bleu
        -- be green if a function is you
        vim.api.nvim_set_hl(0, "CmpItemKindText", { bg = "NONE", link = "Normal" })
        -- classes are red
        vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = colors.crimson })
        -- vars are bleu
        vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = colors.sky }) -- Also for Field, Property
        vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = colors.sky }) -- Also for Variable, Property
        vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = colors.sky }) -- Also for Variable, Field
        -- be green if a function is you
        vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = colors.lime }) -- Also for Method
        vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = colors.lime }) -- Also for Function
        vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = colors.lime })
        -- the rest of the lsp kinds are sporting some kind of pink color
        vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = colors.magenta })
        vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = colors.violet })
        vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = colors.lavender })
        vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = colors.hotpink }) -- Also for EnumMember
        vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = colors.hotpink }) -- Also for Enum
        -- other exotic lsp kind animals
        vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = colors.lavender })
        vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = colors.lavender })
        vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = colors.lavender })
        vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = colors.teal })
        vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = colors.green })
        vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = colors.coral })
        vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = colors.salmon })
        vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = colors.lavender })
        vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = colors.lavender })
        vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = colors.lavender })
        -- other sources
        vim.api.nvim_set_hl(0, "CmpItemKindCalc", { fg = colors.maroon })
        vim.api.nvim_set_hl(0, "CmpItemKindRg", { fg = colors.orange })
    end,
}
