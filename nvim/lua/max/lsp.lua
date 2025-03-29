vim.lsp.enable({
  "lua_ls",
  "denols",
  "jsonls",
  "lua_ls",
  "ruby_lsp",
  "rustproof",
  "tailwindcss",
  "ts_ls",
  "volar",
})

vim.api.nvim_create_user_command("LspInfo", ":checkhealth vim.lsp", {
  desc = "Language server info",
})

vim.api.nvim_create_user_command("LspRestart", function()
  vim.lsp.stop_client(vim.lsp.get_clients())
  vim.defer_fn(function()
    vim.cmd("edit")
  end, 1000)
end, {
  desc = "Restart all language servers",
})
