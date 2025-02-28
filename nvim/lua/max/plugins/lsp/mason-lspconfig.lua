return {
  { "williamboman/mason.nvim", lazy = true },
  {
    event = "VeryLazy",
    "williamboman/mason-lspconfig.nvim",
    ---@type MasonLspconfigSettings
    opts = {
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
    },
  },
}
