return {
    "rgroli/other.nvim",
    keys = {
        { "go", "<cmd>Other<cr>", desc = "goto other" },
        { "gO", "<cmd>OtherVSplit<cr>", desc = "goto other vsplit" },
    },
    config = function()
        require("other-nvim").setup({
            mappings = {
                "livewire",
                "angular",
                "laravel",
                "rails",
                "golang",
                {
                    -- python src -> test
                    pattern = "src/(.*)/(.*).py$",
                    target = "tests/%1/test_%2.py",
                    context = "test",
                },
            },
            transformers = {
                -- defining a custom transformer
                lowercase = function(inputString)
                    return inputString:lower()
                end,
            },
            style = {
                -- How the plugin paints its window borders
                -- Allowed values are none, single, double, rounded, solid and shadow
                border = "solid",
                -- Column seperator for the window
                seperator = "|",
                -- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
                width = 0.8,
                minHeight = 2,
            },
        })
    end,
}
