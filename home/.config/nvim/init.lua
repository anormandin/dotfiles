--require("vim._core.ui2").enable({})

-- Modern Neovim Configuration

-- Leader key (must be set before lazy)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


vim.g.netrw_banner = 0

-- Core options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
-- vim.opt.timeoutlen = 1000
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.laststatus = 3
vim.opt.guicursor = ""
vim.opt.colorcolumn = "0"

vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.shortmess:append("c")

-- @ character in filenames
vim.opt.isfname:append("@-@")
--
-- -- Highlight on yank
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   desc = "Highlight when yanking text",
--   callback = function()
--     vim.hl.on_yank()
--   end,
-- })

require("config.keymaps")
require("config.commands")
require("config.pack")



-- -- Bootstrap lazy.nvim
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--   vim.fn.system({
--     "git", "clone", "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable",
--     lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)

-- -- Load plugins
-- require("lazy").setup("plugins", {
--   change_detection = { notify = false },
-- })
--
-- -- Load keymaps after plugins
