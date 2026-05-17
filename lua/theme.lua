pcall(function()
  local catppuccin = require("catppuccin")
  if catppuccin then
    catppuccin.setup()
    vim.cmd("colorscheme catppuccin-macchiato")
  end
end)
