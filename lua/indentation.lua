-- General indentation settings
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = -1
vim.o.smarttab = true
vim.o.smartindent = true
pcall(function()
  local guess_indent = require("guess-indent")
  if guess_indent then
    guess_indent.setup({})
    vim.api.nvim_exec_autocmds("BufReadPost", { buffer = 0 })
  end
end)
