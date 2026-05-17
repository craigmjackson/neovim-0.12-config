pcall(function()
  vim.lsp.config("clangd", {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders=true",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    settings = {
      clangd = {
        InlayHints = {
          Designators = true,
          Enabled = true,
          ParameterNames = true,
          DeducedTypes = true,
        },
      },
    },
  })
  vim.lsp.enable("clangd")
  -- For generating compile_commands.json
  -- * cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
  --   -or-
  -- * compiledb make
  --   -or-
  -- * bear -- make
end)
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("CIndent", { clear = true }),
  pattern = { "c", "cpp" },
  command = "setlocal shiftwidth=4 tabstop=4",
})
