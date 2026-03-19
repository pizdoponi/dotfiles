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
-- other
vim.opt.mouse = "a" -- enable mouse support
vim.opt.termguicolors = true
vim.opt.cursorline = true -- highlight the line and line number of the current line for better visibility
vim.opt.signcolumn = "yes" -- always reserve space for signs (e.g. diagnostics) to prevent annoying adjustements
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

-- ── Autocmds ────────────────────────────────────────────────────────
-- Always open help pages on the right, with a fixed width.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help" },
  callback = function(event)
    vim.api.nvim_win_set_config(0, { split = "right" })
    vim.api.nvim_win_set_width(0, 88)
  end
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
      { out,                            "WarningMsg" },
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
    -- add your plugins here
    { "catppuccin/nvim",   name = "catppuccin", priority = 1000, config = function() vim.cmd.colorscheme("catppuccin") end },
    { "tpope/vim-fugitive" },
    {
      "neovim/nvim-lspconfig",
      config = function()
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
        vim.lsp.enable({ "lua_ls", "ty", "ruff" })

        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(event)
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            vim.notify_once("Client " .. client.name .. " connected.")

            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = false })

            -- vim.keymap.set("n", "<leader>ff",
            --   function() vim.lsp.buf.format({ async = true, timeout_ms = 3000, id = client.id }) end)
          end
        })
      end
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        local ts = require("nvim-treesitter")
        local ensure_installed = { "python", "lua", "luadoc" }
        local installed = ts.get_installed()

        for _, lang in ipairs(ensure_installed) do
          if not vim.tbl_contains(installed, lang) then
            ts.install(lang)
          end
        end
      end
    },
    {
      "saghen/blink.cmp",
      version = '1.*',
      event = "InsertEnter",
      config = true
    },
    {
      "stevearc/oil.nvim",
      config = function()
        local oil = require("oil")
        oil.setup({})

        vim.keymap.set("n", "<leader>o", oil.open)
      end
    },
    {
      "folke/flash.nvim",
      config = function()
        local flash = require("flash")
        vim.keymap.set("n", "s", flash.jump)
        vim.keymap.set("n", "S", function() flash.treesitter() end)
      end
    },
    {
      "ibhagwan/fzf-lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        local fzf = require("fzf-lua")

        vim.keymap.set("n", "<leader>ff", fzf.files)
        vim.keymap.set("n", "<leader>fh", fzf.helptags)
      end
    },
    {
      "github/copilot.vim",
      event = "InsertEnter",
      config = function()
        vim.g.copilot_filetypes = { env = false }
      end
    },
    { "LudoPinelli/comment-box.nvim", cmd = { "CBlline", "CBllline" } },
  },
  -- Colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin" } },
  -- Do not automatically check for plugin updates.
  checker = { enabled = false },
})

---Prints a table for debugging purposes.
---@param tbl table
function Log(tbl)
  print(vim.inspect(tbl))
end
