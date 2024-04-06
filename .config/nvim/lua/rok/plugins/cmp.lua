return {
    "hrsh7th/nvim-cmp",
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
        local cmp_action = require("lsp-zero").cmp_action()

        -- load the snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            sources = {
                { name = "nvim_lsp", priority = 100, group_index = 0 },
                { name = "nvim_lua", priority = 100, group_index = 0 },
                { name = "luasnip",  priority = 100, group_index = 0 },
                { name = "buffer",   priority = 100, group_index = 0 },
                { name = "path",     priority = 100, group_index = 0 },
            },
            sorting = {
                priority_weight = 2,
                comparators = {
                    -- place _var and __method__ at the end of the completion list. for python
                    function(entry1, entry2)
                        local _, entry1_under = entry1.completion_item.label:find("^_*")
                        local _, entry2_under = entry2.completion_item.label:find("^_*")
                        entry1_under = entry1_under or 0
                        entry2_under = entry2_under or 0
                        if entry1_under > entry2_under then
                            return false
                        elseif entry1_under < entry2_under then
                            return true
                        end
                    end,
                    -- Default comparators
                    cmp.config.compare.score,
                    cmp.config.compare.exact,
                    cmp.config.compare.offset,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            mapping = cmp.mapping.preset.insert({
                -- NOTE: confirm mapping is set in keymaps.lua
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                -- luasnip
                ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                -- supbertab
                ["<Tab>"] = cmp_action.luasnip_supertab(),
                ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
            }),
            preselect = cmp.PreselectMode.None,
            -- completion = {
            --     completeopt = 'menu,menuone,noinsert'
            -- },
            formatting = {
                -- changing the order of fields so the icon is the first
                fields = { "kind", "abbr", "menu" },

                -- here is where the change happens
                format = function(entry, item)
                    local kind_icon = {
                        Text = "󰯁",
                        Class = "󱗃",
                        Constructor = "",
                        Method = "󰊕",
                        Function = "󰡱",
                        Field = "󱂑",
                        Variable = "󱂑",
                        Property = "󱂑",
                        Interface = "󱗁",
                        Module = "󰅩",
                        Unit = "󰑭",
                        Value = "󰎠",
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
                        Copilot = "",
                    }
                    local menu_icon = {
                        nvim_lsp = "󰘧",
                        luasnip = "󰀫",
                        buffer = "󰬴",
                        path = "",
                        nvim_lua = "",
                        copilot = "",
                    }
                    -- item.menu = "[" .. (menu_icon[entry.source.name] or "") .. "]" .. " " .. item.kind
                    item.menu = ""
                    item.kind = kind_icon[item.kind] or ""
                    -- format tailwind
                    return require("tailwindcss-colorizer-cmp").formatter(entry, item)
                end,
            },
            window = {
                completion = cmp.config.window.bordered({
                    border = "single",
                    col_offset = -3,
                }),
            },
        })

        -- setting the colors
        local tokyo_night_base_colors = {
            background = "#1a1b26",
            foreground = "#c0caf5",
            cursor = "#c0caf5",
            black = "#414868",
            red = "#f7768e",
            green = "#9ece6a",
            yellow = "#e0af68",
            blue = "#7aa2f7",
            magenta = "#bb9af7",
            cyan = "#7dcfff",
            white = "#a9b1d6",
            bright_black = "#414868",
            bright_red = "#f7768e",
            bright_green = "#9ece6a",
            bright_yellow = "#e0af68",
            bright_blue = "#7aa2f7",
            bright_magenta = "#bb9af7",
            bright_cyan = "#7dcfff",
            bright_white = "#c0caf5",
        }
        -- vim.api.nvim_set_hl(0, "CmpItemAbbr", {fg = "white"})
        -- vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "white", bg = "black" })
        vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = tokyo_night_base_colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = tokyo_night_base_colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = tokyo_night_base_colors.bright_green })
        vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = tokyo_night_base_colors.green })        -- Also for Function
        vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = tokyo_night_base_colors.green })      -- Also for Method
        vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = tokyo_night_base_colors.light_blue })    -- Also for Variable, Property
        vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = tokyo_night_base_colors.light_blue }) -- Also for Field, Property
        vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = tokyo_night_base_colors.light_blue }) -- Also for Variable, Field
        vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = tokyo_night_base_colors.bright_red })
        vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = tokyo_night_base_colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = tokyo_night_base_colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = tokyo_night_base_colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = tokyo_night_base_colors.bright_cyan }) -- Also for EnumMember
        vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = tokyo_night_base_colors.cyan })  -- Also for Enum
        vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = tokyo_night_base_colors.bright_magenta })
        vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = tokyo_night_base_colors.magenta })
        vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = tokyo_night_base_colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = tokyo_night_base_colors.red })
        vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = tokyo_night_base_colors.bright_green })
        vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = tokyo_night_base_colors.bright_red })
        vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = tokyo_night_base_colors.blue })
        vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = tokyo_night_base_colors.magenta })
        vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = tokyo_night_base_colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = tokyo_night_base_colors.white })
        vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = tokyo_night_base_colors.white })
        -- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = tokyo_night_base_colors.green })
    end,
}
