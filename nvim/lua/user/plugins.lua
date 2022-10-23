local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Color scheme
  use {
    "catppuccin/nvim",
    as = "catppuccin"
  }

  -- Mason package manager
  use 'williamboman/mason.nvim'    
  use 'williamboman/mason-lspconfig.nvim'

  -- Status line
  use 'nvim-lualine/lualine.nvim'
  
end)

