return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    opts = {
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 50,
      },
      signature = { enabled = true },
    },
  },
}
