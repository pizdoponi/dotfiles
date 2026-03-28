-- ── Global variables ────────────────────────────────────────────────
-- Make sure to setup `mapleader` and `maplocalleader` before loading any plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ── Options ─────────────────────────────────────────────────────────
vim.opt.compatible = false -- I use neovim btw. not vi
-- numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- clipboard
vim.opt.clipboard = "unnamed,unnamedplus" -- sync with system clipboard (* and + registers)
-- insert
vim.opt.completeopt = "menuone,popup,noinsert"
vim.opt.backspace = "indent,eol,nostop" -- intuitive backspace
-- searching
vim.opt.ignorecase = true -- make search case insensitive
vim.opt.smartcase = true -- make search case sensitive when using Capital Letters
vim.opt.incsearch = true -- show matches while typing
vim.opt.hlsearch = true -- highlight search matches
vim.opt.magic = true -- make searching magical
-- indenting
vim.opt.autoindent = true -- new line has the same indentation
vim.opt.smartindent = true -- smartly increase indenting when suitable, i.e. after {
vim.opt.tabstop = 4 -- number of spaces a tab is displayed as
vim.opt.softtabstop = 4 -- number of spaces inserted/deleted when editing
vim.opt.shiftwidth = 4 -- spaces used when doing shifting with >> or <<
vim.opt.expandtab = true -- convert tabs into spaces
vim.opt.smarttab = true -- insert tabstop when pressing tab
-- windows
vim.opt.splitright = true -- split new windows to the right
vim.opt.splitbelow = true -- split new windows below
-- scrolling
vim.opt.startofline = true -- move cursor to first non-blank character on big movements
vim.opt.scrolloff = 8 -- number of context lines above and below when scrolling
-- whitespace
vim.opt.wrap = true -- break long lines
vim.opt.linebreak = true -- move whole world to new line when wrapping instead of breaking the word in the middle
vim.opt.showbreak = "++" -- display this at the start of wrapped lines
-- command line completion
vim.opt.wildmenu = true -- enhanced : completions
vim.opt.wildoptions = "pum" -- how : completions are displayed
vim.opt.wildmode = "longest:full,full" -- on first <tab> complete to the longest common prefix and show completion menu, on second <tab> (or if no common prefix) select the first item from completion menu
vim.opt.history = 999 -- number of remembered : commands
-- backup
local undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.undofile = true
vim.opt.undolevels = 1000 -- the number of persisted undo history
vim.opt.undodir = undodir
vim.fn.mkdir(undodir, "p")
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
-- errors
vim.opt.errorbells = false -- no beeps on error
vim.opt.visualbell = true -- flash the screen on error (instead of beep)
-- folds
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldenable = true
vim.o.foldlevel = 99 -- open all folds by default
vim.o.foldlevelstart = 99 -- open all folds when opening a file

function _G.custom_foldtext()
	local start_line_num = vim.v.foldstart
	local end_line_num = vim.v.foldend
	local line_count = end_line_num - start_line_num + 1

	local function normalize(line)
		line = (line or ""):gsub("\t", "  ")
		return vim.trim(line)
	end

	local function is_useful(line)
		local stripped = line:gsub("%s+", "")
		return stripped ~= "" and stripped ~= "{"
	end

	local line = ""

	for lnum = start_line_num, end_line_num do
		local candidate = normalize(vim.fn.getline(lnum))
		if is_useful(candidate) then
			line = candidate
			break
		end
	end

	-- Fallback if the whole fold is blank / braces only
	if line == "" then
		line = normalize(vim.fn.getline(start_line_num))
	end

	local max_width = 88
	if vim.fn.strdisplaywidth(line) > max_width then
		local out = {}
		local width = 0

		for _, ch in ipairs(vim.fn.split(line, "\\zs")) do
			local ch_width = vim.fn.strdisplaywidth(ch)
			if width + ch_width > max_width - 3 then
				break
			end
			out[#out + 1] = ch
			width = width + ch_width
		end

		line = table.concat(out) .. "..."
	end

	return (" %s [%d]"):format(line, line_count)
end

vim.opt.foldtext = "v:lua.custom_foldtext()"

-- other
vim.opt.mouse = "a" -- enable mouse support
vim.opt.termguicolors = true
vim.opt.cursorline = true -- highlight the line and line number of the current line for better visibility
vim.opt.signcolumn = "yes" -- always reserve space for signs (e.g. diagnostics) to prevent annoying adjustments
vim.opt.diffopt:append("vertical") -- show diffs vertically, not horizontally
vim.opt.autoread = true -- update the buffer if file changed externally (for example in vs code)

-- ── Keymaps ─────────────────────────────────────────────────────────
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

-- ── Autocmds ────────────────────────────────────────────────────────
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
-- ── Formatting ──────────────────────────────────────────────────────
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
-- ──────────────────────────────────────────────────────────────────────

---Prints a table for debugging purposes.
---@param tbl table
function Log(tbl)
	print(vim.inspect(tbl))
end
