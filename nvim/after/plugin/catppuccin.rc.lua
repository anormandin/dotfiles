local status, it = pcall(require, "catppuccin")
if (not status) then return end

vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
it.setup()
vim.api.nvim_command "colorscheme catppuccin"


