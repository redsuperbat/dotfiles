return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "md", "markdown", "codecompanion" },
  config = function()
    require("render-markdown").setup({
      file_types = { "md", "codecompanion" },
    })
  end,
}
