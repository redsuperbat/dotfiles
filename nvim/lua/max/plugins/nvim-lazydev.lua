return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      "luvit-meta/library",
      { path = "wezterm-types", mods = { "wezterm" } },
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
