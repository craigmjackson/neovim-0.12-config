vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    -- Check the native capabilities table directly instead of calling a method
    if client and client.server_capabilities.inlayHintProvider then
      -- Turn them on for the current buffer
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end
  end,
})
