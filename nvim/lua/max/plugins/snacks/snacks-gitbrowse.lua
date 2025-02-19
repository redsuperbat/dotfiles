---@diagnostic disable: missing-fields

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    gitbrowse = {},
  },
  keys = {
    {
      "<leader>go",
      function()
        require("snacks").gitbrowse.open()
      end,
      desc = "Open file on github",
    },
  },
}
