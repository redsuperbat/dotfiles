return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  --- @type conform.setupOpts
  opts = {
    format_on_save = {},
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { lsp_format = "prefer" },
      ruby = { "rubocop" },
      javascript = { "biome", "prettier" },
      fish = { "fish_indent" },
      terraform = { "terraform_fmt" },
      sh = { "shfmt" },
      sql = { "sqlfluff" },
    },
  },
}
