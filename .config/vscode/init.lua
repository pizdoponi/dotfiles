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
		"tpope/vim-repeat",
		"tpope/vim-surround",
		"LudoPinelli/comment-box.nvim",
		{
			"jinh0/eyeliner.nvim",
			enabled = false,
			config = function()
				require("eyeliner").setup({
					higlight_on_key = true,
					dim = true,
				})

				local color = "#FF007F" -- rose
				vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = color, bold = true })
				vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = color })
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			enabled = false,
			event = "VeryLazy",
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
			},
			config = function()
				---@diagnostic disable-next-line: missing-fields
				require("nvim-treesitter.configs").setup({
					textobjects = {
						select = {
							enable = true,
							lookahead = true,
							keymaps = {
								["af"] = { query = "@function.outer" },
								["if"] = { query = "@function.inner" },
								["ac"] = { query = "@class.outer" },
								["ic"] = { query = "@class.inner" },
							},
						},
						swap = {
							enable = false,
						},
						move = {
							enable = true,
							set_jumps = true, -- whether to set jumps in the jumplist
							goto_next_start = {
								["]]"] = { query = "@function.outer" },
								["]C"] = { query = "@class.outer" },
							},
							goto_previous_start = {
								["[["] = { query = "@function.outer" },
								["[C"] = { query = "@class.outer" },
							},
						},
					},
				})

				local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

				-- vim way: ; goes to the direction you were moving.
				vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
				vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

				vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
				vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
				vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
				vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
			end,
		},
		{
			"folke/flash.nvim",
			opts = {
				jump = {
					nohlsearch = true,
					autojump = false,
				},
				modes = {
					char = {
						enabled = false,
					},
				},
			},
			keys = {
				{
					"s",
					mode = { "n", "x" },
					function()
						require("flash").jump()
					end,
					desc = "Flash",
				},
				{
					"S",
					mode = "n",
					function()
						require("flash").treesitter()
					end,
					desc = "Flash Treesitter",
				},
			},
		},
		{
			"andrewferrier/debugprint.nvim",
			opts = {
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
			},
		},
	},
	checker = { enabled = false },
	defaults = {
		version = "*", -- Install the latest stable version for plugins that support semantic versioning.
	},
})
