-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Remove unused import on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.ts*",
  command = ":TSToolsRemoveUnusedImports sync",
})

-- Fix conceallevel for markdown files
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("markdown_conceal"),
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Activate virtual environment for python
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    require("swenv.api").auto_venv()
  end,
})
