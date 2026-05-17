pcall(function()
  local global_node_modules = vim.fn.trim(vim.fn.system("npm root -g"))
  local vue_plugin_path = global_node_modules .. "/@vue/language-server"
  vim.lsp.config("vtsls", {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    settings = {
      javascript = {
        inlayHints = {
          parameterNames = { enabled = "all" },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      typescript = {
        inlayHints = {
          parameterNames = { enabled = "all" },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_plugin_path,
              languages = { "vue" },
              configNamespace = "typescript",
              enableForWorkspaceTypescriptVersions = true,
            },
          },
        },
      },
    },
  })
  vim.lsp.enable("vtsls")
end)
