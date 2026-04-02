-- ── Global variables ────────────────────────────────────────────────
-- Make sure to setup `mapleader` and `maplocalleader` before loading any plugins.
-- Or setting any keymaps that use <leader> or <localleader>.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("rm.options")
require("rm.keymaps")
require("rm.autocmds")

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
			version = "*",
			name = "catppuccin",
			priority = 1000,
			config = function()
				vim.cmd.colorscheme("catppuccin")
			end,
		},
		-- ── Core ────────────────────────────────────────────────────────────
		{ "neovim/nvim-lspconfig", version = "*" },
		{
			"nvim-treesitter/nvim-treesitter",
			version = "*",
			build = ":TSUpdate",
			config = function()
				local ts = require("nvim-treesitter")
				local ensure_installed = { "lua", "luadoc", "markdown", "markdown_inline", "python" }
				local installed = ts.get_installed()

				for _, lang in ipairs(ensure_installed) do
					if not vim.tbl_contains(installed, lang) then
						ts.install(lang)
					end
				end
			end,
		},
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
							preselect = true,
							auto_insert = false,
						},
					},
				},
				signature = { enabled = true, window = { show_documentation = false, border = "single" } },
				keymap = {
					preset = "none",
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-n>"] = { "accept", "fallback" },
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
			"stevearc/oil.nvim",
			version = "*",
			config = function()
				local oil = require("oil")
				oil.setup({})

				vim.keymap.set("n", "<leader>o", oil.open, { desc = "[o]il" })
			end,
		},
		{
			"stevearc/conform.nvim",
			version = "*",
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
		{
			"folke/flash.nvim",
			version = "*",
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
				{ "f", "f" },
				{ "F", "F" },
				{ "t", "t" },
				{ "T", "T" },
			},
			opts = {},
		},
		{
			"ibhagwan/fzf-lua",
			version = "*",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			cmd = "FzfLua",
			keys = {
				{ "<leader>f<leader>", "<Cmd>FzfLua<CR>", desc = "[f]ind FzfLua builtin" },
				{
					"<leader><leader>",
					"<Cmd>FzfLua combine pickers=git_files;lsp_workspace_symbols<CR>",
					desc = "Fzf workspace",
				},
				{ "<leader>ff", "<Cmd>FzfLua files<CR>", desc = "[f]ind [f]iles" },
				{ "<leader>fh", "<Cmd>FzfLua helptags<CR>", desc = "[f]ind [h]elp" },
				{ "<leader>fc", "<Cmd>FzfLua commands<CR>", desc = "[f]ind [c]ommands" },
				{ "<leader>fd", "<Cmd>FzfLua lsp_document_diagnostics<CR>", desc = "[f]ind document [d]iagnostics" },
				{ "<leader>fD", "<Cmd>FzfLua lsp_document_diagnostics<CR>", desc = "[f]ind workspace [D]iagnostics" },
				{ "<leader>fs", "<Cmd>FzfLua lsp_workspace_symbols<CR>", desc = "[f]ind [s]ymbols" },
			},
			opts = {},
		},
		-- ── Git ─────────────────────────────────────────────────────────────
		{ "tpope/vim-fugitive", version = "*", event = "VeryLazy" },
		{
			"lewis6991/gitsigns.nvim",
			version = "*",
			event = "VeryLazy",
			opts = {
				signs = {
					add = { text = "+" },
					change = { text = "~" },
				},
			},
		},
		{
			"zbirenbaum/copilot.lua",
			version = "*",
			event = "InsertEnter",
			cmd = "Copilot",
			opts = {
				filetypes = {
					env = false,
				},
				suggestion = {
					auto_trigger = true,
					hide_during_completion = false,
					keymap = {
						accept = "<Tab>",
						accept_line = "<C-l>",
						dismiss = "<C-o>",
					},
				},
				panel = {
					enabled = false,
				},
			},
		},
		{
			"nvim-lualine/lualine.nvim",
			version = "*",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			event = "VeryLazy",
			opts = {
				sections = {
					lualine_x = { "filetype" },
					lualine_y = { "progress" },
					-- lualine_z = {"searchcount, selectioncount"},
					lualine_z = {},
				},
			},
		},
		{
			"jpalardy/vim-slime",
			version = "*",
			keys = {
				{ "<leader>s", "<Plug>SlimeRegionSend", mode = "x", desc = "Slime send selection" },
				{ "<leader>s", "<Plug>SlimeMotionSend", mode = "n", desc = "Slime send motion" },
				{ "<leader>ss", "<Plug>SlimeLineSend", mode = "n", desc = "Slime send line" },
			},
			init = function()
				vim.g.slime_target = "wezterm"
				vim.g.slime_default_config = { pane_direction = "right" }
				vim.g.slime_no_mapping = 1
				vim.g.slime_bracketed_pasting = 0
			end,
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			version = "*",
			main = "ibl",
			opts = {},
		},
		{ "LudoPinelli/comment-box.nvim", version = "*", cmd = { "CBlline", "CBllline" } },
		{
			"tpope/vim-surround",
			version = "*",
			keys = {
				{ "ds", mode = "n", desc = "Delete surrounding" },
				{ "cs", mode = "n", desc = "Change surrounding" },
				{ "ys", mode = "n", desc = "Add surrounding" },
			},
		},
		{ "j-hui/fidget.nvim", version = "*", event = "LspAttach", opts = {} },
	},
	-- Colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin" } },
	-- Do not automatically check for plugin updates.
	checker = { enabled = false },
})

-- ── LSP ─────────────────────────────────────────────────────────────
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
-- ── Diagnostics ─────────────────────────────────────────────────────
vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	jump = {
		float = true,
	},
	float = {
		border = "single",
	},
})
