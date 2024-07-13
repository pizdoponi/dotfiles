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
            .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
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
                    name = "ChatGemma2",
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
                    gp.info("Implementing selection with agent: " .. agent.name)

                    gp.Prompt(
                        params,
                        gp.Target.rewrite,
                        nil, -- command will run directly without any prompting for user input
                        agent.model,
                        template,
                        agent.system_prompt
                    )
                end,
                Explain = function(gp, params)
                    local template = "```{{filetype}}\n{{selection}}\n```\n\n"
                        .. "Explain the code above. First provide a high-level overview of the code, "
                        .. "then explain the code in detail."
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
            },
        })
    end,
}
