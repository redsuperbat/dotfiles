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
      schemas = {
        {
          fileMatch = { "tsconfig.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          fileMatch = { "package.json" },
          url = "https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/package.json",
        },
      },
    },
  },
}
