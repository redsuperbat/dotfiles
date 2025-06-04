---@module "lazy"
---@type LazySpec
return {
  "MagicDuck/grug-far.nvim",
  opts = {},
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sR",
      function()
        require("grug-far").open()
      end,
    },
  },
}
