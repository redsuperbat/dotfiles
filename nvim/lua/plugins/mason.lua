return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")

    mason.setup({
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
        "typescript-language-server",
        "graphql",
        "emmet_ls",
        "marksman",
        "prismals",
        "pyright",
      },
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "taplo",
        "isort",
        "black",
        "pylint",
        "eslint_d",
      },
    })
  end,
}
