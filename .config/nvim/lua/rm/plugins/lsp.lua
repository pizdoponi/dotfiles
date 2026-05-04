return {
	{ "neovim/nvim-lspconfig", version = "*" },
	{ "https://github.com/mason-org/mason.nvim", opts = {} }, -- Lazy loading mason is not recommended.
	{ "j-hui/fidget.nvim", version = "*", event = "LspAttach", enabled = false, opts = {} },
}
