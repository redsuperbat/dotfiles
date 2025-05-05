---@type vim.lsp.Config
return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_dir = function(buf, cb)
    local deno_json_found = vim.fs.root(buf, {
      "deno.json",
    })
    if deno_json_found ~= nil then
      return
    end
    local found = vim.fs.root(buf, {
      "package.json",
      "tsconfig.json",
      ".git",
    })
    if found == nil then
      return
    end
    cb(found)
  end,
  init_options = {
    hostInfo = "neovim",
  },
}
