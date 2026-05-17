pcall(function()
  local lazydev = require("lazydev")
  if lazydev then
    lazydev.setup()
  end
end)
local lazydev_ok, lazydev = pcall(require, "lazydev")
if lazydev_ok then
  lazydev.setup()
end
pcall(function()
  vim.lsp.enable({ "lua_ls" })
end)
