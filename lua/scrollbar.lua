pcall(function()
  local scroll_bar = require("scrollbar")
  if scroll_bar then
    scroll_bar.setup({
      handlers = {
        gitsigns = true,
      },
      marks = vim.g.nerd_font and {} or {
        Cursor = {
          text = "*",
        },
        Search = {
          text = { "-", "=" },
        },
        Error = {
          text = { "-", "=" },
        },
        Warn = {
          text = { "-", "=" },
        },
        Info = {
          text = { "-", "=" },
        },
        Hint = {
          text = { "-", "=" },
        },
        Misc = {
          text = { "-", "=" },
        },
        GitAdd = {
          text = "|",
        },
        GitChange = {
          text = "|",
        },
        GitDelete = {
          text = "_",
        },
      },
    })
  end
end)
