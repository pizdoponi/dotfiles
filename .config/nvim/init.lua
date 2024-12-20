if vim.g.vscode then
    require("rok.vscode")
    return
end

vim.keymap.set("n", "<space>", "<nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

require("lazy").setup("rok.plugins", {
    change_detection = {
        notify = false,
    },
})

-- config
require("rok.keymaps")
require("rok.options")
require("rok.autocmds")
require("rok.repeatable_move")
require("rok.custom.load_lazy_plugin")
