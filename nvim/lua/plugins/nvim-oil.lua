return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  keys = {

    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    { "<leader>e", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },
  config = function(_, opts)
    require("oil").setup(opts)
  end,
}
