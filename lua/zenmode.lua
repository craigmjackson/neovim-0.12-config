pcall(function()
  local zenmode = require("zen-mode")
  if zenmode then
    zenmode.setup({
      window = {
        width = 0.95,
      },
    })
    vim.keymap.set("n", "<leader>z", ":ZenMode<cr>", { noremap = true })
  end
end)
