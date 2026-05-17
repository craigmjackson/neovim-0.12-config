local function check_url_simple(url)
  vim.fn.system({ "curl", "-Isf", url, "-o", "/dev/null" })
  local success = (vim.v.shell_error == 0)
  return success
end

-- Install plugins if site is reachable
if check_url_simple("https://github.com/neovim") then
  vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/folke/lazydev.nvim" },
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    { src = "https://github.com/catppuccin/nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/Bekaboo/dropbar.nvim" },
    { src = "https://github.com/akinsho/bufferline.nvim" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/petertriho/nvim-scrollbar" },
    { src = "https://github.com/NMAC427/guess-indent.nvim" },
    { src = "https://github.com/folke/zen-mode.nvim" },
    { src = "https://github.com/sitiom/nvim-numbertoggle" },
    { src = "https://github.com/seblyng/roslyn.nvim" },
  }, { confirm = false })
end
if check_url_simple("https://codeberg.org/mfussenegger") then
  vim.pack.add({
    { src = "https://codeberg.org/mfussenegger/nvim-jdtls.git" },
  }, { confirm = false })
end
