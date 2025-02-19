return {
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = true },
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "html",
          "cssls",
          "volar",
          "tailwindcss",
          "svelte",
          "jsonls",
          "sorbet",
          "intelephense",
          "lua_ls",
          "denols",
          "ts_ls",
          "graphql",
          "terraformls",
          "rust_analyzer",
          "docker_compose_language_service",
          "prismals",
          "marksman",
          "pyright",
        },
        automatic_installation = true,
      })

      require("mason-tool-installer").setup({
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
      })
    end,
  },
}
