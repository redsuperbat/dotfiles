---@module "lazy"
---@type LazySpec
return {
  "tpope/vim-surround",
  dependencies = {
    "tpope/vim-repeat",
  },
  event = "BufReadPre",
}
