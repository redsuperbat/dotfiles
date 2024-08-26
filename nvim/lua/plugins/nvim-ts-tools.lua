return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    separate_diagnostic_server = true,
    expose_as_code_action = {
      "remove_unused_imports",
    },
  },
}
