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
