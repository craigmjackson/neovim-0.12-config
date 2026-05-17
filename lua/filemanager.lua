pcall(function()
  local nvim_tree = require("nvim-tree")
  if nvim_tree then
    nvim_tree.setup({
      disable_netrw = true,
      hijack_netrw = true,
      filters = {
        git_ignored = false,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      renderer = {
        icons = {
          web_devicons = {
            file = {
              enable = vim.g.nerd_font,
              color = true,
            },
            folder = {
              enable = vim.g.nerd_font,
              color = true,
            },
          },
          glyphs = vim.g.nerd_font and {} or {
            default = "",
            symlink = "",
            bookmark = "",
            modified = "m",
            hidden = "",
            folder = {
              arrow_closed = ">",
              arrow_open = "v",
              default = "d",
              open = "d",
              empty = "d",
              empty_open = "d",
              symlink = "ds",
              symlink_open = "ds",
            },
            git = {
              unstaged = "",
              staged = "s",
              unmerged = "",
              untracked = "",
              deleted = "d",
              ignored = "",
            },
          },
        },
      },
    })
  end
  vim.keymap.set("n", "<c-n>", ":NvimTreeToggle<cr>", { noremap = true })
end)
