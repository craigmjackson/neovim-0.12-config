pcall(function()
  local bufferline = require("bufferline")
  if bufferline then
    bufferline.setup({
      options = {
        nubmers = "ordinal",
        separator_style = "slant",
        buffer_close_icon = vim.g.nerd_font and "" or "x",
        close_icon = vim.g.nerd_font and "" or "x",
        modified_icon = vim.g.nerd_font and "" or "m",
        left_trunc_marker = vim.g.nerd_font and "" or "/",
        right_trunc_marker = vim.g.nerd_font and "" or "\\",
      },
    })
  end
  vim.keymap.set("n", "<leader>b", ":BufferLineGoToBuffer ", { desc = "Open [B]uffer (tab) number", noremap = true })
  vim.keymap.set("n", "<leader><Tab>", ":BufferLineCycleNext<CR>", { desc = "Cycle next tab", noremap = true })
  vim.keymap.set(
    "n",
    "<leader><Shift-Tab>",
    ":BufferLineCyclePrev<CR>",
    { desc = "Cycle previous tab", noremap = true }
  )
end)
