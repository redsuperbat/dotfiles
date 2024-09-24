local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    async = false,
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  keys = {
    {
      "<leader>cf",
      function()
        lsp_formatting(vim.api.nvim_get_current_buf())
      end,
      mode = { "n" },
      desc = "Format buffer",
    },
  },
  config = function()
    local nls = require("null-ls")

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        lsp_formatting(vim.api.nvim_get_current_buf())
      end,
    })

    nls.setup({
      sources = {
        nls.builtins.code_actions.refactoring,

        nls.builtins.diagnostics.actionlint,
        nls.builtins.diagnostics.codespell,

        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.biome.with({
          args = {
            "check",
            "--write",
            "--stdin-file-path",
            "$FILENAME",
          },
        }),

        nls.builtins.diagnostics.fish,
        nls.builtins.formatting.fish_indent,

        nls.builtins.formatting.prettier.with({
          -- Exclude js/ts json because biome handles that
          disabled_filetypes = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "json",
            "jsonc",
          },
        }),
      },
    })
  end,
}
