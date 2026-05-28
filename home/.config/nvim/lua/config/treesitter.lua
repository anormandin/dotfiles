local treesitter = require("nvim-treesitter")
local ensure_installed = {
  "lua", "javascript", "tsx", "html", "css", "json", "bash", "markdown"

}
treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    -- Try to start treesitter for the current buffer
    local ok, _ = pcall(vim.treesitter.start)
    if ok then
      -- Optional: Enable treesitter-based folding
      -- vim.wo.foldmethod = "expr"
      -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      
      -- Optional: Enable treesitter-based indentation
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

