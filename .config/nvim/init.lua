vim.keymap.set("n", "<space>", "<nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("i", "jk", "<esc>")

require("rok.keymaps")
require("rok.options")
require("rok.autocmds")

-- NOTE: dynamically set python path
vim.g.python3_host_prog = string.gsub(vim.fn.system("which python"), "\n", "")

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- init lazy
require("lazy").setup("rok.plugins", {

    change_detection = {
        notify = false,
    },
})
