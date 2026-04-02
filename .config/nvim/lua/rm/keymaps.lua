-- These are plugin independent keymaps.
-- Plugin related keymaps are set in the config function when loading that plugin.
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
vim.keymap.set("i", "<A-BS>", "<C-w>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "p", '"_dP')
-- window
vim.keymap.set("n", "<C-left>", "<Cmd>wincmd h<CR>")
vim.keymap.set("n", "<C-down>", "<Cmd>wincmd j<CR>")
vim.keymap.set("n", "<C-up>", "<Cmd>wincmd k<CR>")
vim.keymap.set("n", "<C-right>", "<Cmd>wincmd l<CR>")
-- scrolling
vim.keymap.set("n", "<C-e>", function()
	return math.max(1, math.floor(vim.fn.winheight(0) / 10)) .. "<C-e>"
end, { expr = true })
vim.keymap.set("n", "<C-y>", function()
	return math.max(1, math.floor(vim.fn.winheight(0) / 10)) .. "<C-y>"
end, { expr = true })
-- diagnostics
vim.keymap.set("n", "[e", function()
	vim.diagnostic.jump({ count = 1, float = true, severtity = vim.diagnostic.severity.ERROR })
end, { desc = "Jump to next error" })
vim.keymap.set("n", "]e", function()
	vim.diagnostic.jump({ count = -1, float = true, severtity = vim.diagnostic.severity.ERROR })
end, { desc = "Jump to previous error" })
