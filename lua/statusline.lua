pcall(function()
  local statusline = require("mini.statusline")
  if statusline then
    statusline.setup({
      use_icons = vim.g.nerd_font,
    })
  end
end)
