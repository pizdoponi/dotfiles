-- ── Global variables ────────────────────────────────────────────────
-- Make sure to setup `mapleader` and `maplocalleader` before loading any plugins.
-- Or setting any keymaps that use <leader> or <localleader>.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("rm.options")
require("rm.keymaps")
require("rm.autocmds")
require("rm.lsp")
require("rm.abbr_git")

-- ── Diagnostics ─────────────────────────────────────────────────────
vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	jump = {
		float = true,
	},
})

-- ── Plugins ─────────────────────────────────────────────────────────
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000,
			config = function()
				vim.cmd.colorscheme("catppuccin")
			end,
		},
		{ import = "rm.plugins.lsp" },
		{ import = "rm.plugins.treesitter" },
		{ import = "rm.plugins.completion" },
		{ import = "rm.plugins.ui" },
		{ import = "rm.plugins.git" },
		{ import = "rm.plugins.format" },
		{
			"stevearc/oil.nvim",
			config = function()
				local oil = require("oil")
				oil.setup({
					float = {
						border = "single",
					},
				})

				vim.keymap.set("n", "<leader>o", oil.open, { desc = "[o]il" })
			end,
		},
		{
			"folke/flash.nvim",
			keys = {
				{
					"s",
					function()
						require("flash").jump()
					end,
					mode = { "n", "x", "o" },
					desc = "Flash",
				},
				{
					"S",
					function()
						require("flash").treesitter()
					end,
					mode = { "n", "x", "o" },
					desc = "Flash Treesitter",
				},
			},
			opts = {
				modes = { char = { enabled = false } },
			},
		},
		{
			"ibhagwan/fzf-lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			cmd = "FzfLua",
			keys = {
				{ "<leader>f<leader>", "<Cmd>FzfLua<CR>", desc = "FzfLua builtin" },
				{
					"<leader><leader>",
					"<Cmd>FzfLua combine pickers=git_files;lsp_workspace_symbols<CR>",
					desc = "Fzf workspace",
				},
				{ "<leader>ff", "<Cmd>FzfLua files<CR>", desc = "[f]ind [f]iles" },
				{ "<leader>fh", "<Cmd>FzfLua helptags<CR>", desc = "[f]ind [h]elp" },
				{
					"<leader>fH",
					function()
						local helpfiles = vim.api.nvim_get_runtime_file("doc/*.txt", true)
						require("fzf-lua").live_grep({
							search_paths = helpfiles,
							prompt = "Grep Help> ",
						})
					end,
					desc = "Grep helptags",
				},
				{ "<leader>f/", "<Cmd>FzfLua live_grep<CR>", desc = "FzfLua live_grep" },
				{ "<leader>fw", "<Cmd>FzfLua grep_cword<CR>", desc = "FzfLua grep_cword" },
				{ "<leader>fW", "<Cmd>FzfLua grep_cWORD<CR>", desc = "FzfLua grep_cWORD" },
				{ "<leader>fc", "<Cmd>FzfLua commands<CR>", desc = "FzfLua commands" },
				{ "<leader>fd", "<Cmd>FzfLua lsp_document_diagnostics<CR>", desc = "[f]ind document [d]iagnostics" },
				{ "<leader>fD", "<Cmd>FzfLua lsp_document_diagnostics<CR>", desc = "[f]ind workspace [D]iagnostics" },
				{ "<leader>fs", "<Cmd>FzfLua lsp_workspace_symbols<CR>", desc = "[f]ind [s]ymbols" },
			},
			opts = {},
		},
		{
			"jpalardy/vim-slime",
			keys = {
				{ "<leader>s", "<Plug>SlimeRegionSend", mode = "x", desc = "Slime send selection" },
				{ "<leader>s", "<Plug>SlimeMotionSend", mode = "n", desc = "Slime send motion" },
				{ "<leader>ss", "<Plug>SlimeLineSend", mode = "n", desc = "Slime send line" },
			},
			init = function()
				vim.g.slime_target = "wezterm"
				vim.g.slime_default_config = { pane_direction = "right" }
				vim.g.slime_no_mapping = 1
				vim.g.slime_bracketed_paste = 1
			end,
		},
		{ "LudoPinelli/comment-box.nvim", cmd = { "CBlline", "CBllline" } },
		{ "tpope/vim-surround", event = "VeryLazy" },
		{ "mfussenegger/nvim-dap", lazy = true },
		{
			"Goose97/timber.nvim",
			event = "VeryLazy",
			opts = {
				keymaps = { insert_log_below = "gll" },
				log_templates = {
					default = {
						python = [[print(f"%watcher_marker_start | %filename:%line_number | {%log_target=} | %watcher_marker_end")]],
						-- python = [[print(f"%filename:%line_number {%log_target=}")]],
					},
					plain = {
						python = [[print(f"%filename:%line_number %insert_cursor")]],
					},
				},
				log_watcher = {
					enabled = true,
					sources = { log_file = { name = "Log file", type = "filesystem", path = "/tmp/timber.log" } },
				},
			},
		},
		{
			"szw/vim-maximizer",
			init = function()
				vim.g.maximizer_set_default_mapping = 0
			end,
			keys = {
				{ "<C-w>m", "<Cmd>MaximizerToggle<CR>", desc = "Toggle window maximization" },
			},
		},
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	-- Colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin" } },
	-- Do not automatically check for plugin updates.
	checker = { enabled = false },
	defaults = {
		version = nil,
	},
})
