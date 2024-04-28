return {
    "Wansmer/treesj",
    enabled = false,
    keys = { "<space>m", "<cmd>lua require('treesj').toggle()<cr>", desc = "[m]odify tree toggle" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("treesj").setup({ --[[ your config ]]
        })
        -- vim.keymap.set("n", "<space>j", "<cmd>lua require('treesj').toggle()<cr>", { desc = "[J]oin tree toggle" })
    end,
}
