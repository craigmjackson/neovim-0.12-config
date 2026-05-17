pcall(function()
  vim.lsp.config("intelephense", {
    filetypes = { "php" },
    -- Force the server to root itself based on standard PHP project markers
    root_dir = vim.fs.root(0, { ".git", "composer.json", "index.php" }),
    settings = {
      intelephense = {
        files = {
          maxSize = 5000000, -- Prevent choking on massive vendor files (5MB limit)
        },
        format = {
          enable = true, -- Enables built-in PSR-12 formatting support
        },
        environment = {
          phpVersion = "8.5", -- Target your runtime PHP version (e.g., "8.2", "8.3", "8.4")
        },
        inlayHints = {
          parameterTypes = { enabled = true },
          parameterNames = { enabled = "all" },
          variableTypes = { enabled = true },
        },
      },
    },
  })
  -- Enable the server globally
  vim.lsp.enable("intelephense")
end)
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("PhpIndent", { clear = true }),
  pattern = { "php" },
  command = "setlocal shiftwidth=4 tabstop=4",
})
