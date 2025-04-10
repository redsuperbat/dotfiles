vim.lsp.enable({
  "biome",
  "denols",
  "jsonls",
  "lua_ls",
  "lua_ls",
  "marksman",
  "ruby_lsp",
  "gopls",
  "rust-analyzer",
  "rustproof",
  "tailwindcss",
  "terraformls",
  "ts_ls",
  "volar",
})

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd(string.format("view %s", vim.lsp.get_log_path()))
end, {
  desc = "Open lsp logs",
})

vim.api.nvim_create_user_command("LspInfo", ":checkhealth vim.lsp", {
  desc = "Language server info",
})

vim.api.nvim_create_user_command("LspStart", function(ctx)
  local config = vim.lsp.config[ctx.args]
  vim.lsp.start(config)
end, {
  desc = "Open lsp logs",
  nargs = 1,
})

vim.api.nvim_create_user_command("LspStop", function(ctx)
  vim.lsp.stop_client(vim.lsp.get_clients({ name = ctx.args }))
end, {
  desc = "Stop lsp client",
  nargs = 1,
})

vim.api.nvim_create_user_command("LspRestart", function()
  vim.lsp.stop_client(vim.lsp.get_clients())
  vim.defer_fn(function()
    vim.cmd("edit")
  end, 1000)
end, {
  desc = "Restart all language servers",
})
