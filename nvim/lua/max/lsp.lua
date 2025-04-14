--- This code enables all language servers
--- with configuration in the lsp directory
local lsp_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "lsp")
--- @type string[]
local language_servers_to_enable = {}
for filename in vim.fs.dir(lsp_dir) do
  local lsp_name = filename:gsub("%.lua$", "")
  if filename:match("%.lua$") then
    table.insert(language_servers_to_enable, lsp_name)
  end
end
vim.lsp.enable(language_servers_to_enable)

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
  desc = "Start lsp with name",
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
