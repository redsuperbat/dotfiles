return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "md", "markdown", "codecompanion" },
  config = function()
    require("render-markdown").config()
    require("max.utils.theme").set_bg("RenderMarkdownCode")
  end,
}
