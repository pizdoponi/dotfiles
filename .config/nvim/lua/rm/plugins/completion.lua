return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"bydlw98/blink-cmp-env",
			"erooke/blink-cmp-latex",
		},
		event = "InsertEnter",
		opts = {
			sources = {
				default = { "lsp", "buffer", "snippets", "path", "env" },
				per_filetype = {
					tex = { inherit_default = true, "latex" },
				},
				providers = {
					env = {
						-- Triggered with $ in insert mode, for example when writing $API_KEY.
						name = "Env",
						module = "blink-cmp-env",
						opts = {
							-- item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
							show_braces = false, -- Show as $API_KEY instead of ${API_KEY}.
							show_documentation_window = true, -- Show the value of the variable.
						},
					},
					latex = {
						name = "Latex",
						module = "blink-cmp-latex",
						opts = {
							insert_command = true,
						},
					},
				},
			},
			cmdline = { enabled = true },
			completion = {
				menu = { auto_show = true, border = "single", scrollbar = false },
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 50,
					update_delay_ms = 50,
					window = { border = "single" },
				},
				ghost_text = { enabled = false },
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
			},
			signature = { enabled = true, window = { show_documentation = false, border = "single" } },
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" }, -- Accept only if item is selected.
				["<C-y>"] = { "select_and_accept", "fallback" },
				["<C-e>"] = { "hide", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-f>"] = { "snippet_forward", "fallback" },
				["<C-b>"] = { "snippet_backward", "fallback" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
		},
	},
	{
		"zbirenbaum/copilot.lua",
		version = "*",
		event = "InsertEnter",
		cmd = "Copilot",
		config = function()
			local opts = {
				filetypes = {
					env = false,
				},
				suggestion = {
					auto_trigger = true,
					hide_during_completion = false,
					keymap = {
						accept = false, -- Disable default accept keymap to use custom Tab mapping.
						accept_line = "<C-l>",
						dismiss = "<C-c>",
					},
				},
				panel = {
					enabled = false,
				},
			}
			local copilot = require("copilot")
			copilot.setup(opts)

			local suggestion = require("copilot.suggestion")

			-- Accept Copilot suggestion with Tab, or insert a Tab if no suggestion is visible.
			-- Alternatively, <C-i> can be used, as it is the same as Tab.
			vim.keymap.set("i", "<Tab>", function()
				if suggestion.is_visible() then
					suggestion.accept()
					return ""
				else
					return "<Tab>"
				end
			end, { expr = true, replace_keycodes = true, desc = "Accept Copilot suggestion or insert Tab" })
		end,
	},
}
