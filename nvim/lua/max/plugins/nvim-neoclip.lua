return {
  "AckslD/nvim-neoclip.lua",
  events = { "VeryLazy" },
  keys = {

    {
      "<leader>cb",
      function()
        vim.cmd("Telescope neoclip")
      end,
      desc = "Show clib board history",
    },
    {
      "<leader>cm",
      function()
        vim.cmd("Telescope macroscope")
      end,
      desc = "Show macro history",
    },
  },
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    require("neoclip").setup({
      enable_macro_history = true,
      keys = {
        telescope = {
          i = {
            select = "<cr>",
            paste = nil,
            paste_behind = "<c-k>",
            replay = nil,
            delete = nil,
            edit = "<c-e>", -- edit an entry
            custom = {},
          },
          n = {
            select = "<cr>",
            paste = "p",
            paste_behind = "P",
            replay = nil,
            delete = "d",
            edit = "e",
            custom = {},
          },
        },
      },
    })
  end,
}
