return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  event = { "VeryLazy" },
  version = "v0.*",
  config = function()
    require("blink.cmp").setup({
      keymap = {
        preset = "default",
        ["<C-b>"] = { "select_and_accept" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 50,
        },
      },
      signature = { enabled = true },
    })
  end,
}
