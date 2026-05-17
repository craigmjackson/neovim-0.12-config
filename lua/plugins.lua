local function check_url_simple(url)
  vim.fn.system({ 'curl', '-Isf', url, '-o', '/dev/null' })
  local success = (vim.v.shell_error == 0)
  return success
end

-- Install plugins if site is reachable
if check_url_simple('https://github.com/neovim') then
  vim.pack.add({
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/folke/lazydev.nvim' },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
    { src = 'https://github.com/catppuccin/nvim' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
    { src = 'https://github.com/nvim-mini/mini.nvim' }
  }, {confirm = false})
end
