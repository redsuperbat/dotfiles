---@type vim.lsp.Config
return {
  cmd = { "/opt/homebrew/bin/rust-analyzer" },
  filetypes = { "rust" },
  capabilities = {
    experimental = {
      serverStatusNotification = true,
    },
  },
  root_markers = {
    "Cargo.toml",
  },
}
