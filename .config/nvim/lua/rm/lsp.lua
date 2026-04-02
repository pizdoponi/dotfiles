vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
					quote_style = "double",
				},
			},
		},
	},
})
vim.lsp.enable({ "lua_ls", "ty", "ruff", "clangd" })

local connected_clients = {}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end

		-- local ft = vim.bo[event.buf].filetype
		-- local client_key = client.name .. "::" .. ft
		local client_key = client.name

		if connected_clients[client_key] == nil then
			connected_clients[client_key] = true
			-- vim.notify_once(client.name .. " started.")
			require("fidget").notify(client.name .. " started.")
		end

		-- Uncomment the line below if not using blink.cmp or any other completion plugin, to use native LSP completion.
		-- vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = false })

		-- Use border for LSP hover and signature help windows.
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "single" })
		end, { buffer = event.buf, desc = "Hover" })
		vim.keymap.set("i", "<C-s>", function()
			vim.lsp.buf.signature_help({ border = "single" })
		end, { buffer = event.buf, desc = "Signature help" })
	end,
})
