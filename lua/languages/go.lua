pcall(function()
  vim.lsp.config("gopls", {
    root_dir = vim.fs.root(0, { "go.work", "go.mod", ".git" }),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
        gofumpt = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  })
  vim.lsp.enable("gopls")
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      local win_id = 0
      local offset_encoding = "utf-8"
      local clients = vim.lsp.get_clients({ bufnr = 0, name = "gopls" })
      if next(clients) == nil then
        return
      end
      local gopls_client = clients[1]
      offset_encoding = gopls_client.offset_encoding or "utf-8"
      local base_params = vim.lsp.util.make_range_params(win_id, offset_encoding)
      local params = vim.tbl_deep_extend("force", base_params, {
        context = { only = { "source.organizeImports" } },
      })
      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
      for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            vim.lsp.util.apply_workspace_edit(r.edit, offset_encoding)
          elseif r.command then
            gopls_client:request("workspace/executeCommand", r.command, nil, 0)
          end
        end
      end
      vim.lsp.buf.format({ async = false })
    end,
  })
end)
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("GoIndent", { clear = true }),
  pattern = { "go" },
  command = "setlocal shiftwidth=4 tabstop=4 expandtab=false",
})
