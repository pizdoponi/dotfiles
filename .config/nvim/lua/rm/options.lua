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
-- other
vim.opt.mouse = "a" -- enable mouse support
vim.opt.termguicolors = true
vim.opt.cursorline = true -- highlight the line and line number of the current line for better visibility
vim.opt.signcolumn = "yes" -- always reserve space for signs (e.g. diagnostics) to prevent annoying adjustments
vim.opt.diffopt:append("vertical") -- show diffs vertically, not horizontally
vim.opt.autoread = true -- update the buffer if file changed externally (for example in vs code)
