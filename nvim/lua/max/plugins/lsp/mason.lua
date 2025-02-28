return {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  ---@type MasonSettings
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
}
