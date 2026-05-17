pcall(function()
  local conform = require("conform")
  if conform then
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        vue = { "prettier" },
        bash = { "shfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        cs = { "csharpier" },
        css = { "prettier" },
        go = { "gofumpt" },
        html = { "prettier" },
        markdown = { "prettier" },
        php = { "php_cs_fixer" },
        rust = { "rustfmt" },
        sql = { "sql_formatter" },
        toml = { "taplo" },
        json = { "prettier", "jq", stop_after_first = true },
        yaml = { "prettier", "yamlfmt", stop_after_first = true },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
      },
    })
    conform.formatters.shfmt = {
      prepend_args = { "-i", "2" },
    }
  end
end)
