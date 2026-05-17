pcall(function()
  local minipick = require("mini.pick")
  if minipick then
    minipick.setup({
      source = {
        show = minipick.default_show,
      },
      window = {
        prompt_caret = "|",
        prompt_prefix = "> ",
      },
      show_icons = vim.g.nerd_font,
    })
    local pick_neovim_config = function()
      local picked_filename = minipick.start({
        source = {
          items = vim.fn.readdir(vim.fn.stdpath("config")),
        },
      })
      if picked_filename then
        local filename_with_path = vim.fn.stdpath("config") .. "/" .. picked_filename
        vim.cmd("edit " .. filename_with_path)
      end
    end
    -- Fuzzy find for file in the project
    vim.keymap.set("n", "<leader>sf", ":Pick files<cr>", { noremap = true })
    -- Fuzzy find for content in the project
    vim.keymap.set("n", "<leader>sg", ":Pick grep_live<cr>", { noremap = true })
    -- Fuzzy find NeoVim config files
    vim.keymap.set("n", "<leader>sn", pick_neovim_config, { noremap = true })
  end
end)
