pcall(function()
  vim.lsp.enable("basedpyright")
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("PythonIndent", { clear = true }),
    pattern = { "python" },
    command = "setlocal shiftwidth=4 tabstop=4",
  })
end)
