local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "nvim-lua/plenary.nvim",
  },
}

M.servers = {
  "lua_ls",
  "cssls",
  "html",
  "tsserver",
  "bashls",
  "jsonls",
  "yamlls",
  "marksman",
}

function M.config()
  local wk = require "which-key"
  wk.add {
  {"<leader>lI", "<cmd>Mason<cr>", desc="Mason Info" },
  }

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }
  require("mason-lspconfig").setup {
    ensure_installed = M.servers,
  }
end

return M
