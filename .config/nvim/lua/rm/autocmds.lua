-- Always open help pages on the right, with a fixed width.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help" },
	---@diagnostic disable-next-line: unused-local
	callback = function(event)
		vim.api.nvim_win_set_config(0, { split = "right" })
		vim.api.nvim_win_set_width(0, 88)
	end,
})

-- Set .env filetype. (To exclude them from copilot).
vim.cmd("autocmd BufReadPost,BufNewFile *.env,*.env.* setfiletype env")

-- Format before saving a buffer.
-- To disable formatting on save, set `vim.g.format_on_save` to false.
-- I.e. run `:lua vim.g.format_on_save = false` to disable, and `:lua vim.g.format_on_save = true` to enable.
vim.g.format_on_save = true

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(event)
		if not vim.g.format_on_save then
			return
		end

		-- Format with conform.nvim if available
		local ok, conform = pcall(require, "conform")
		if ok then
			conform.format({ bufnr = event.buf, timeout_ms = 3000 })
			return
		end

		-- Fallback to LSP formatting if conform.nvim is not available, and if the attached LSP client supports formatting.
		local clients = vim.lsp.get_clients({ bufnr = event.buf })
		for _, client in ipairs(clients) do
			if client.supports_method and client.supports_method("textDocument/formatting") then
				vim.lsp.buf.format({ bufnr = event.buf, timeout_ms = 3000 })
			end
		end
	end,
})
