vim.api.nvim_create_user_command("PackAdd", function(opts)
  vim.pack.add(opts.fargs)
end, {nargs = "+", desc = "Add plugins (:PackAdd user/repo)"} )

vim.api.nvim_create_user_command("PackDel", function(opts)
  vim.pack.del(opts.fargs)
end, {nargs = "+", desc = "Delete plugins (:PackDel plug1 plug2)"} )

vim.api.nvim_create_user_command("PackUpdate", function(opts)
  if opts.args:match("%S") then
    local plugins = vim.split(opts.args, "%s+", { trimempty = true })
    vim.pack.update(plugins)
  else
    -- no parameters, update all
    vim.pack.update()
  end
end, { nargs = "*", desc = "Update plugins" })
