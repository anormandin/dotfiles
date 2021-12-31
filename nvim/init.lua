-- Map leader to space
require'lualine'.get_config()
vim.g.mapleader = ' '

local fn = vim.fn
local execute = vim.api.nvim_command

-- Sensible defaults
require('settings')


-- Auto install packer.nvim if not exists
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua


-- Install all plugins
require('plugins')

-- Key mappings
require('keymappings')

-- Setup language servers
require('lsp_lua')


-- Config
require('config.colorscheme')
require('config.completion')
require('config.fugitive')
require('config.lualine')
require('config.nvimtree')
