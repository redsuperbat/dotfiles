--- @diagnostic disable: missing-fields

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    scratch = {
      ft = nil,
      filekey = {
        cwd = true,
        branch = false,
        count = false,
      },
      win = {
        height = 0.9,
        width = 0.9,
        backdrop = false,
        keys = {
          -- Do not close on q, fallback to normal behaviour
          ["q"] = function()
            vim.api.nvim_feedkeys("q", "n", true)
          end,
        },
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
