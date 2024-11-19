local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()

  local which_key = require "which-key"
  which_key.setup {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    win = {
      padding = { 2, 2 },
    },
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  which_key.add({
    {"<leader>q>", "<cmd>confirm q<CR>", desc="Quit" },
    {"<leader>T", group="Treesitter"},
    {"<leader>b", group="Buffers"},
    {"<leader>d", group="Debug"},
    {"<leader>f", group="Find"},
    {"<leader>g", group="Git"},
    {"<leader>l", group="LSP"},
    {"<leader>p", group="Plugins"},
    {"<leader>t", group="Tests"},
    {"<leader>a", group="Tabs"},
    {"<leader>an", "<cmd>tabnew<CR>", desc="New Empty Tab"},
    {"<leader>aN", "<cmd>tabnew<CR>", desc="New Tab"},
    {"<leader>ao", "<cmd>tabonly<CR>", desc="Only"},
    {"<leader>ah", "<cmd>-tabmove<CR>", desc="Move Left"},
    {"<leader>al", "<cmd>+tabmove<CR>", desc="Move Right"},
    {"<leader><cr>", "<cmd>nohlsearch<CR>", desc="NOHL"},
    {"<leader>;", "<cmd>tabnew | terminal<CR>", desc="Terminal"},


  })
end

return M
