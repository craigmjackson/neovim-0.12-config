pcall(function()
  local git_signs = require("gitsigns")
  if git_signs then
    local opts = vim.g.nerd_font and {}
      or {
        signs = {
          add = { text = "|" },
          change = { text = "|" },
          delete = { text = "_" },
          topdelete = { text = "_" },
          changedelete = { text = "~" },
          untracked = { text = " " },
        },
        signs_staged = {
          add = { text = "|" },
          change = { text = "|" },
          delete = { text = "_" },
          topdelete = { text = "_" },
          changedelete = { text = "~" },
          untracked = { text = " " },
        },
      }
    git_signs.setup(opts)
  end
end)
