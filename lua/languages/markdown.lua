vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = function(opts)
    pcall(function()
      local render_markdown = require("render-markdown")
      render_markdown.setup({
        completions = {
          lsp = {
            enabled = true,
          },
        },
      })
      if vim.bo[opts.buf].filetype == "markdown" then
        vim.cmd("RenderMarkdown enable")
      end
    end)
  end,
})
