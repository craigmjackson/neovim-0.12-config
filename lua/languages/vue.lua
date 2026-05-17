pcall(function()
  vim.lsp.config("vue_ls", {
    filetypes = { "vue" },
  })
  vim.lsp.enable("vue_ls")
end)
