vim.o.autocomplete = true
vim.opt.complete:append("o")
vim.opt.completeopt = { "menuone", "noselect" }
vim.o.pumheight = 10
vim.o.pumborder = "rounded"
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end,
})
