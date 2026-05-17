-- On linux, ensure "Microsoft.CodeAnalysis.LanguageServer" is available in your PATH
-- TODO: integrate this on Windows
-- local roslyn_bin = vim.fn.expand("~/.local/share/roslyn/content/LanguageServer/linux-x64")
-- If you are on Linux/macOS, execute it via the global dotnet runtime launcher
-- local cmd = { "dotnet", roslyn_bin }
-- If you are natively on Windows, run the executable directly:
-- if vim.fn.has("win32") == 1 then
--   cmd = { roslyn_bin .. ".exe" }
-- end
pcall(function()
  require("roslyn").setup({
    args = {
      "--logLevel=Information",
      "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.log.get_filename()),
    },
    config = {
      -- cmd = cmd,
      root_dir = vim.fs.root(0, { "*.sln", "*.csproj", "OmniSharp.json", ".git" }),
      settings = {
        csharp = {
          inlayHints = {
            enableForParameters = true,
            forLiteralParameters = true,
            forIndexerParameters = true,
            forLambdaParameterTypes = true,
            forImplicitObjectCreation = true,
          },
        },
      },
    },
  })
end)
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("CsIndent", { clear = true }),
  pattern = { "cs" },
  command = "setlocal shiftwidth=4 tabstop=4",
})
