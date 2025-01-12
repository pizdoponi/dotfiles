return {
    {
        "chrisgrieser/nvim-origami",
        event = "BufReadPost", -- later or on keypress would prevent saving folds
        opts = {
            keepFoldsAcrossSessions = true,
            setupFoldKeymaps = false,
        },
        config = function(_, opts)
            require("origami").setup(opts)

            vim.keymap.set("n", "<Left>", function()
                require("origami").h()
            end)
            vim.keymap.set("n", "<Right>", function()
                require("origami").l()
            end)
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        event = "VeryLazy",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        init = function()
            vim.o.foldenable = true
            vim.o.foldmethod = "manual"
            vim.o.foldcolumn = "0"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            vim.cmd("highlight Folded guifg=NONE guibg=NONE")
        end,
        opts = {
            provider_selector = function(_, filetype, _)
                local lspWithOutFolding = { "markdown", "sh", "css", "html", "python" }
                if vim.tbl_contains(lspWithOutFolding, filetype) then
                    return { "treesitter", "indent" }
                end
                return { "lsp", "indent" }
            end,
            close_fold_kinds_for_ft = {
                python = { "imports" },
            },
            open_fold_hl_timeout = 0,
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (" 󰁂 %d "):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end,
        },
        config = function(_, opts)
            local ufo = require("ufo")
            ufo.setup(opts)

            vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
            vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
            vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { desc = "Open folds" })
            vim.keymap.set("n", "zm", ufo.closeFoldsWith, { desc = "Close folds" })

            vim.keymap.set("n", "K", function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end, { desc = "LSP hover / peek fold" })
        end,
    },
}
