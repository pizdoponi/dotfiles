return {
    { "vim-scripts/restore_view.vim" },
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
            "chrisgrieser/nvim-origami",
        },
        init = function()
            -- "0" means that fold level is not shown in the sidebar
            vim.o.foldcolumn = "0"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
        end,
        opts = {
            provider_selector = function(_, filetype, _)
                -- INFO some filetypes only allow indent, some only LSP, some only
                -- treesitter. However, ufo only accepts two kinds as priority,
                -- therefore making this function necessary :/
                local lspWithOutFolding = { "markdown", "sh", "css", "html", "python" }
                if vim.tbl_contains(lspWithOutFolding, filetype) then
                    return { "treesitter", "indent" }
                end
                return { "lsp", "indent" }
            end,
            open_fold_hl_timeout = 800,
            -- format function copied from ufo's docs
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
            require("ufo").setup(opts)

            vim.keymap.set("n", "zR", function()
                require("ufo").openAllFolds()
            end, { desc = "Open all folds" })
            vim.keymap.set("n", "zM", function()
                require("ufo").closeAllFolds()
            end, { desc = "Close all folds" })
            -- NOTE: here is the hover on K
            vim.keymap.set("n", "K", function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end, { desc = "Hover / peek fold" })
            vim.keymap.set("n", "z<cr>", function()
                require("ufo.action").closeFolds(vim.v.count)
            end, { desc = "Close folds with v:count" })
        end,
    },
}
