--- @diagnostic disable: missing-fields

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    scratch = {
      win = {
        backdrop = false,
      },
    },
  },
  keys = {
    {
      "<leader>.",
      function()
        require("snacks").scratch.open()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        require("snacks").scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
  },
}
