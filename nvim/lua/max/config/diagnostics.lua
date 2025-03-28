vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_user_command("VirtualLinesToggle", function()
  vim.diagnostic.config({
    virtual_lines = not vim.diagnostic.config().virtual_lines,
    virtual_text = not vim.diagnostic.config().virtual_text,
  })
end, {
  desc = "Toggle virtual lines",
})
