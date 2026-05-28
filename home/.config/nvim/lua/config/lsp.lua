require("mason").setup()


-- Default keybindings

-- gri    Go to implementation
-- grt    Go to type definition
-- grr    Find references
-- grn    Rename
-- gra    Code Action
-- grx    Code lens
-- gO     Symbols
-- <c-s>  Signature help (insert mode)
-- K      Hover

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
-- vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float,  { desc = "Show Line diagnostics" })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = "Format buffer" })

vim.diagnostic.config({
  virtual_text = true,
  underline = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } }
    }
  }
})

-- vim.lsp.config("omnisharp")

vim.lsp.enable({
  "lua_ls",
  "omnisharp"
})
