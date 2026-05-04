local vscode = require("vscode")

vim.opt.wrap = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 4

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- vim.keymap.set("n", "<C-up>", "<C-w>k", { desc = "Move to upper split" })
-- vim.keymap.set("n", "<C-right>", "<C-w>l", { desc = "Move to right split" })
-- vim.keymap.set("n", "<C-down>", "<C-w>j", { desc = "Move to lower split" })
-- vim.keymap.set("n", "<C-left>", "<C-w>h", { desc = "Move to left split" })
-- vim.keymap.set("n", "<C-S-up", function()
-- 	vscode.action("workbench.action.moveEditorToAboveGroup")
-- end, { desc = "Move split up" })
-- vim.keymap.set("n", "<C-S-right>", function()
-- 	vscode.action("workbench.action.moveEditorToRightGroup")
-- end, { desc = "Move split right" })
-- vim.keymap.set("n", "<C-S-down>", function()
-- 	vscode.action("workbench.action.moveEditorToBelowGroup")
-- end, { desc = "Move split down" })
-- vim.keymap.set("n", "<C-S-left>", function()
-- 	vscode.action("workbench.action.moveEditorToLeftGroup")
-- end, { desc = "Move split left" })
-- vim.keymap.set("n", "<C-w>m", function()
-- 	vscode.action("workbench.action.toggleMaximizeEditorGroup")
-- end, { desc = "Toggle maximize split" })

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(event)
		local name, kind = event.data.spec.name, event.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not event.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/tpope/vim-repeat",
	"https://github.com/tpope/vim-surround",
	"https://github.com/folke/flash.nvim",
	"https://github.com/LudoPinelli/comment-box.nvim",
	"https://github.com/andrewferrier/debugprint.nvim",
})

require("flash").setup({
	jump = {
		nohlsearch = true,
		autojump = false,
	},
	modes = {
		char = {
			enabled = false,
		},
	},
})

vim.keymap.set({ "n", "x" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set("n", "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })

require("debugprint").setup({
	keymaps = {
		normal = {
			plain_below = "glp",
			plain_above = "glP",
			variable_below = "gll",
			variable_above = "glL",
			variable_below_alwaysprompt = false,
			variable_above_alwaysprompt = false,
			surround_plain = "glsp",
			surround_variable = "glsl",
			surround_variable_alwaysprompt = false,
			textobj_below = false,
			textobj_above = false,
			textobj_surround = false,
			toggle_comment_debug_prints = false,
			delete_debug_prints = false,
		},
		insert = {
			plain = false,
			variable = false,
		},
		visual = {
			variable_below = "gll",
			variable_above = "glL",
		},
	},
})
