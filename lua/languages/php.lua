pcall(function()
  vim.lsp.config("intelephense", {
    filetypes = { "php" },
    root_dir = vim.fs.root(0, { ".git", "composer.json", "index.php" }),
    settings = {
      intelephense = {
        files = {
          maxSize = 5000000,
        },
        format = {
          enable = true,
        },
        environment = {
          phpVersion = "8.5",
        },
        inlayHints = {
          parameterTypes = { enabled = true },
          parameterNames = { enabled = "all" },
          variableTypes = { enabled = true },
        },
      },
    },
  })
  vim.lsp.enable("intelephense")
end)
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("PhpIndent", { clear = true }),
  pattern = { "php" },
  command = "setlocal shiftwidth=4 tabstop=4",
})
