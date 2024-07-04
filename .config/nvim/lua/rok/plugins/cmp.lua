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
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-calc",
        "lukas-reineke/cmp-rg",
        -- TODO: make dictionary work (brew install wordnet)
        -- dont forget to uncomment line below, in the sources list and setup at the botton of config on this page
        -- "uga-rosa/cmp-dictionary",
        "lukas-reineke/cmp-under-comparator",
        -- tailwindcss
        {
            "roobert/tailwindcss-colorizer-cmp.nvim",
            config = function()
                require("tailwindcss-colorizer-cmp").setup({
                    color_square_width = 2,
                })
            end,
        },
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
                { name = "nvim_lsp_signature_help", group_index = 0 },
                { name = "path", group_index = 1 },
                { name = "calc", group_index = 1 },
                { name = "nvim_lsp", group_index = 1 },
                { name = "nvim_lua", group_index = 1 },
                { name = "luasnip", group_index = 1 },
                { name = "buffer", group_index = 1, max_item_count = 5 },
                {
                    name = "rg",
                    keyword_length = 3,
                    group_index = 1,
                    max_item_count = 3,
                },
                -- {
                --     name = "dictionary",
                --     keyword_length = 3,
                --     group_index = 1,
                --     max_item_count = 3,
                -- },
            },
            sorting = {
                priority_weight = 2,
                comparators = {
                    cmp.config.compare.exact,
                    cmp.config.compare.offset,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.scopes,
                    require("cmp-under-comparator").under,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                },
            },
            window = {
                completion = {
                    border = {
                        { "󱐋", "WarningMsg" },
                        { "─", "Comment" },
                        { "╮", "Comment" },
                        { "│", "Comment" },
                        { "╯", "Comment" },
                        { "─", "Comment" },
                        { "╰", "Comment" },
                        { "│", "Comment" },
                    },
                    scrollbar = false,
                    col_offset = -3,
                    winhighlight = "Normal:Normal",
                },
                documentation = {
                    border = {
                        { "", "DiagnosticHint" },
                        { "─", "Comment" },
                        { "╮", "Comment" },
                        { "│", "Comment" },
                        { "╯", "Comment" },
                        { "─", "Comment" },
                        { "╰", "Comment" },
                        { "│", "Comment" },
                    },
                    scrollbar = false,
                },
            },
            -- NOTE: confirm and cancel mappings are set in keymaps.lua
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                -- luasnip
                ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                -- supbertab
                ["<Tab>"] = cmp_action.luasnip_supertab(),
                ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
            }),
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            preselect = cmp.PreselectMode.None,
            formatting = {
                -- changing the order of fields so the icon is the first
                fields = { "kind", "abbr" },
                -- uncomment the line below to include source name in the completion menu
                -- fields = { "kind", "abbr", "menu" },
                format = function(entry, item)
                    local kind_icon = {
                        Text = "󰦨",
                        Class = "󱗃",
                        Constructor = "",
                        Method = "󰊕",
                        Function = "󰊕",
                        Field = "󱂑",
                        Variable = "󱂑",
                        Property = "󱂑",
                        Interface = "󱗁",
                        Module = "󰅩",
                        Unit = "󰬺",
                        Value = "󱂍",
                        Enum = "󱅉",
                        Keyword = "󰌋",
                        Snippet = "",
                        Color = "󰏘",
                        File = "󰈙",
                        Reference = "",
                        Folder = "󰉋",
                        EnumMember = "󱅈",
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
                        item.kind = "󰯁"
                    else
                        item.kind = kind_icon[item.kind] or ""
                    end

                    -- format tailwind
                    return require("tailwindcss-colorizer-cmp").formatter(entry, item)
                end,
            },
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
        -- vim.api.nvim_set_hl(0, "CmpItemAbbr", { bg = "NONE", fg = "#cdd6f4" })
        -- color of the matched text
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = colors.gold })
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
        -- strikethrough deprecated items
        vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
        -- highlight the kind of the item
        -- lsp icons
        vim.api.nvim_set_hl(0, "CmpItemKindText", { bg = "NONE", link = "Normal" })
        vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = colors.lime })
        vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = colors.lime }) -- Also for Function
        vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = colors.lime }) -- Also for Method
        vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = colors.cyan }) -- Also for Variable, Property
        vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = colors.cyan }) -- Also for Field, Property
        vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = colors.cyan }) -- Also for Variable, Field
        vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = colors.lavender })
        vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = colors.lavender })
        vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = colors.lavender })
        vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = colors.sapphire }) -- Also for EnumMember
        vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = colors.sapphire }) -- Also for Enum
        vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = colors.mauve })
        vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = colors.mauve })
        vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = colors.lavender })
        vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = colors.lime })
        vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = colors.blue })
        vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = colors.mauve })
        vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = colors.lavender })
        vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = colors.lavender })
        vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = colors.lavender })
        -- other sources
        vim.api.nvim_set_hl(0, "CmpItemKindCalc", { fg = colors.sapphire })
        vim.api.nvim_set_hl(0, "CmpItemKindRg", { fg = colors.mauve })

        -- setup dictionary
        -- require("cmp_dictionary").setup({
        --     paths = { "/usr/share/dict/words" },
        --     exact_length = 3,
        --     max_number_items = 3,
        --     first_case_insensitive = true,
        --     document = {
        --         enable = true,
        --         command = { "wn", "${label}", "-over" },
        --     },
        -- })
    end,
}
