return {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
        require("chatgpt").setup({
            -- api_host_cmd = "echo -n 'http://127.0.0.1:11434'",
            api_host_cmd = "echo -n http://localhost:11434",
            api_key_cmd = "echo -n 'gratisjezakon'",

            openai_params = {
                model = "gemma2:9b-instruct-q6_K",
                frequency_penalty = 0,
                presence_penalty = 0,
                max_tokens = 3000,
                temperature = 0,
                top_p = 1,
                n = 1,
            },
            openai_edit_params = {
                model = "gemma2:9b-instruct-q6_K",
                frequency_penalty = 0,
                presence_penalty = 0,
                temperature = 0,
                top_p = 1,
                n = 1,
            },
        })
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
}
