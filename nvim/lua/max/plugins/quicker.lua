return {
  "stevearc/quicker.nvim",
  event = "FileType qf",
  keys = {
    {
      "<leader>q",
      function()
        require("quicker").toggle()
      end,
      { desc = "Toggle Quickfix" },
    },
  },
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {},
}
