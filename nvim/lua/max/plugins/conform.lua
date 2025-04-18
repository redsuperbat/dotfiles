return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
      end,
      desc = "Format current buffer",
    },
  },
  --- @module "conform"
  --- @type conform.setupOpts
  opts = {
    format_on_save = {},
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "gofmt" },
      python = { "isort", "black" },
      rust = { lsp_format = "prefer" },
      ruby = { "rubocop" },
      javascript = { "biome", "prettier", stop_after_first = true },
      typescript = { "biome" },
      json = { "biome", lsp_format = "fallback" },
      typescriptreact = { "biome" },
      fish = { "fish_indent" },
      terraform = { "terraform_fmt" },
      dockerfile = { lsp_format = "prefer" },
      sh = { "shfmt" },
      sql = { "sqlfluff" },
    },
  },
}
