vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_user_command("VirtualLinesToggle", function()
  vim.diagnostic.config({
    virtual_lines = not vim.diagnostic.config().virtual_lines,
  })
end, {
  desc = "Toggle virtual lines",
})
