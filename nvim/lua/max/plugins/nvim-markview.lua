return {
  "OXY2DEV/markview.nvim",
  ft = { "markdown", "codecompanion" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>mw",
      function()
        vim.api.nvim_command(":Markview toggle")
      end,
      desc = "Toggle markdown view",
    },
  },
}
