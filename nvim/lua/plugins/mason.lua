return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  event = { "VeryLazy" },
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "html",
        "cssls",
        "volar@1.8.27",
        "tailwindcss",
        "svelte",
        "jsonls",
        "lua_ls",
        "tsserver",
        "graphql",
        "emmet_language_server",
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
