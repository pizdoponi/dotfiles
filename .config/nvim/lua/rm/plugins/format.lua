return {
	{
		"stevearc/conform.nvim",
		lazy = true,
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = function(bufnr)
					if require("conform").get_formatter_info("ruff_format", bufnr).available then
						return { "ruff_format" }
					else
						return { "isort", "black" }
					end
				end,
				["_"] = { "trim_whitespace" },
			},
			default_format_opts = {
				timeout_ms = 3000,
				lsp_format = "fallback",
			},
		},
	},
}
