return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
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
        "volar@1.8.27",
        "tailwindcss",
        "svelte",
        "jsonls",
        "lua_ls",
        "denols",
        "tsserver",
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
        "sqlfluff",
        "biome",
        "taplo", -- markdown formatter?
        "isort", -- python formatter
        "black", -- python formatter
        "pylint",
        "eslint_d",
      },
    })
  end,
}
