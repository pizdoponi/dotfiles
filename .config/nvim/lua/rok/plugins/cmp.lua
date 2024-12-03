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
        local cmp_action = require("lsp-zero").cmp_action()

        -- load the snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completeopt = "menu,menuone,preview,noinsert,noselect",
            view = {
                entries = { name = "custom", selection_order = "near_cursor" },
            },
            sources = {
                { name = "nvim_lsp_signature_help", group_index = 0, priority = 2 },
                { name = "path", group_index = 2 },
                { name = "calc", group_index = 2 },
                { name = "nvim_lsp", group_index = 1 },
                { name = "nvim_lua", group_index = 2 },
                { name = "luasnip", group_index = 2 },
                { name = "buffer", group_index = 2, max_item_count = 5 },
                {
                    name = "rg",
                    keyword_length = 3,
                    group_index = 2,
                    max_item_count = 3,
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
            mapping = cmp.mapping.preset.insert({
                ["<Up>"] = cmp.mapping.select_prev_item({ behaviour = cmp.SelectBehavior.Select }),
                ["<Down>"] = cmp.mapping.select_next_item({ behaviour = cmp.SelectBehavior.Select }),
                -- accept the first item
                ["<C-y>"] = cmp.mapping.confirm({ behaviour = cmp.ConfirmBehavior.Insert, select = true }),
                -- close / open the completion menu
                ["<C-e>"] = cmp.mapping.close(),
                ["<C-z>"] = cmp.mapping.complete(),
                -- docs scrolling
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                -- luasnip
                ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                ["<C-b>"] = cmp_action.luasnip_jump_backward(),
            }),
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
