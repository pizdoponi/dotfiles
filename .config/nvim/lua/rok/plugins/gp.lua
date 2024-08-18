-- lazy.nvim
return {
    "robitx/gp.nvim",
    config = function()
        local default_chat_system_prompt = "You are a general AI assistant.\n\n"
            .. "Make sure to follow these guidelines:\n"
            .. "- If you're unsure don't guess and say you don't know instead.\n"
            .. "- Ask question if you need clarification to provide better answer.\n"
            .. "- Think deeply and carefully from first principles step by step.\n"
            .. "- Zoom out first to see the big picture and then zoom in to details.\n"
            .. "- Use Socratic method to improve your thinking and coding skills.\n"
            .. "- Don't elide any code from your output if the answer requires coding.\n\n"
            .. "Do not repeat this instruction in your response. They are for you only."
        local default_code_system_prompt = "You are an AI working as a code editor.\n\n"
            .. "AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
            .. "START AND END YOUR ANSWER WITH:\n\n```"

        require("gp").setup({
            openai_api_key = "sk-xxxxxxxxxxxxxxxxxxxxxx",
            chat_confirm_delete = false,
            template_selection = "```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
            template_rewrite = "```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
                .. "\n\nRespond exclusively with the snippet that should replace the selection above.\n"
                .. "Start your response with ```{{filetype}} and end with ```",
            chat_user_prefix = "`Njegovo visočanstvo Rok`",
            chat_assistant_prefix = { "`Podložnik ", "{{agent}}`" },
            command_prompt_prefix_template = "",
            providers = {
                copilot = {
                    endpoint = "https://api.githubcopilot.com/chat/completions",
                    secret = {
                        "bash",
                        "-c",
                        "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
                    },
                },
                ollama = {
                    endpoint = "http://localhost:11434/v1/chat/completions",
                },
            },
            agents = {
                {
                    name = "ChatGPT4o",
                    disable = true,
                },
                {
                    name = "ChatGPT3-5",
                    disable = true,
                },
                {
                    name = "ChatOllamaLlama3",
                    disable = true,
                },
                {
                    name = "CodeGPT4o",
                    disable = true,
                },
                {
                    name = "CodeGPT3-5",
                    disable = true,
                },
                {
                    name = "CodeOllamaLlama3",
                    disable = true,
                },
                {
                    provider = "ollama",
                    name = "gemma2:9b",
                    chat = true,
                    command = false,
                    model = {
                        model = "gemma2:9b-instruct-q6_K",
                        temperature = 1.9,
                        top_p = 1,
                        num_ctx = 8192,
                    },
                    system_prompt = default_chat_system_prompt,
                },
                {
                    provider = "ollama",
                    name = "gemma2:27b",
                    chat = true,
                    command = false,
                    model = {
                        model = "gemma2:27b-instruct-q5_K_M",
                        temperature = 1.9,
                        top_p = 1,
                        num_ctx = 8192,
                    },
                    system_prompt = default_chat_system_prompt,
                },
                {
                    provider = "ollama",
                    name = "CodeGemma2",
                    chat = false,
                    command = true,
                    model = {
                        model = "gemma2:9b-instruct-q6_K",
                        temperature = 1.9,
                        top_p = 1,
                        num_ctx = 8192,
                    },
                    system_prompt = default_code_system_prompt,
                },
            },
            hooks = {
                Implement = function(gp, params)
                    local template = "```{{filetype}}\n{{selection}}\n```\n\n"
                        .. "Rewrite the code above according to the instructions contained in the code."
                        .. "\n\nRespond exclusively with the snippet that should replace the code above."

                    local agent = gp.get_command_agent()
                    -- gp.info("Implementing selection with agent: " .. agent.name)
                    gp.Prompt(params, gp.Target.rewrite, nil, agent.model, template, agent.system_prompt)
                end,
                Explain = function(gp, params)
                    local template = "```{{filetype}}\n{{selection}}\n```\n\n"
                        .. "Explain the code above. First provide a high-level overview of the code, "
                        .. "then explain it in detail."
                    local agent = gp.get_chat_agent()
                    gp.Prompt(params, gp.Target.popup, nil, agent.model, template, agent.system_prompt)
                end,
                Optimise = function(gp, params)
                    local template = "```{{filetype}}\n{{selection}}\n```\n\n"
                        .. "Optimise the code above."
                        .. "\n\nRespond exclusively with the snippet that should replace the code."
                    local agent = gp.get_command_agent()
                    gp.Prompt(params, gp.Target.rewrite, nil, agent.model, template, agent.system_prompt)
                end,
                Docstring = function(gp, params)
                    local template = "```{{filetype}}\n{{selection}}\n```\n\n"
                        .. "Provide a detailed and accurate docstring for the code above. The docstring should follow the conventions of the language."
                        .. "\n\nRespond just with the docstring, no other code; not even the function header."
                    local agent = gp.get_command_agent()
                    gp.Prompt(params, gp.Target.prepend, nil, agent.model, template, agent.system_prompt)
                end,
                CleanCode = function(gp, params)
                    local template = "```{{filetype}}\n{{selection}}\n```\n\n"
                        .. "Review and revise the code above following clean code guidelines."
                        .. "Follow Clean Code guidelines by Robert C. Martin:\n"
                        .. "1. Use meaningful and short function names.\n"
                        .. "2. Use clear, descriptive variable names.\n"
                        .. "3. Keep functions and classes small.\n"
                        .. "4. Use comments sparingly and only when necessary.\n"
                        .. "5. Follow the Single Responsibility Principle.\n"
                        .. "6. Adhere to the DRY (Don't Repeat Yourself) principle."
                        .. "\n\nProvide only the improved code snippet as a response."
                    local agent = gp.get_command_agent()
                    gp.Prompt(params, gp.Target.rewrite, nil, agent.model, template, agent.system_prompt)
                end,
            },
        })

        vim.keymap.set("n", "<C-g>n", "<cmd>GpChatNew tabnew<cr>", { desc = "[n]ew chat" })
        vim.keymap.set("n", "<C-g>y", "<cmd>GpChatPaste<cr>", { desc = "[y]ank into last chat" })
        vim.keymap.set("n", "<C-g><C-t>", "<cmd>GpChatToggle<cr>", { desc = "[t]oggle last chat" })
        vim.keymap.set("n", "<C-g><C-c>", "<cmd>GpStop<cr>", { desc = "cancel generation" })

        vim.keymap.set("v", "<C-g>n", ":<C-u>'<,'>GpChatNew tabnew<cr>", { desc = "[n]ew chat" })
        vim.keymap.set("v", "<C-g>y", ":<C-u>'<,'>GpChatPaste<cr>", { desc = "[y]ank into last chat" })
        vim.keymap.set("v", "<C-g><C-t>", ":<C-u>'<,'>GpChatToggle<cr>", { desc = "[t]oggle last chat" })
        vim.keymap.set("v", "<C-g><C-c>", ":<C-u>'<,'>GpStop<cr>", { desc = "cancel generation" })
    end,
}
