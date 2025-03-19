return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  config = function()
    require("lsp_lines").setup()
    vim.diagnostic.config({ virtual_text = false })
    vim.diagnostic.config({ virtual_lines = { highlight_whole_line = false } })
  end,
}
