---@type vim.lsp.Config
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_dir = vim.fn.getcwd(),
  init_options = {
    provideFormatter = true,
  },
  settings = {
    json = {
      format = {
        enable = false,
      },
    },
    validate = { enable = true },
  },
}
