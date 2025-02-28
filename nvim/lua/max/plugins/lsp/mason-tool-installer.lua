return {
  { "williamboman/mason.nvim", lazy = true },
  {
    event = "VeryLazy",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "prettier",
        "cspell",
        "stylua",
        "actionlint",
        "sqlfluff",
        "biome",
        "taplo", -- toml formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint",
        "eslint_d",
      },
    },
  },
}
