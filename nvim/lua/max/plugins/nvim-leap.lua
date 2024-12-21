return {
  enabled = false,
  "ggandor/leap.nvim",
  event = "BufEnter",
  dependencies = {
    -- To be able to repeat with .
    "tpope/vim-repeat",
  },
  init = function()
    require("leap").create_default_mappings()
  end,
}
